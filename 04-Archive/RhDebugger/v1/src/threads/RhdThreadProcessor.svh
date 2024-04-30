`ifndef RhdThreadProcessor__svh
`define RhdThreadProcessor__svh
/*
The pool class stores [[RhdThread.svh|RhdThread]], has static apis that can be called by user or a macro wrapper easily.
*/

class RhdThreadProcessor;

	RhdThread pool[string];
	//uvm_event#(string) updated=new("updated");
	string updated[$]; // use queue instead of event to support multiple updated in one cycle.
	RhdUserInterface ui; // object comming from call of init api.
	bit breakpoints[string];


	// The method called by user, to find if the given method name, location which combines a unique id of the thread is already created or not, if found, then return the RhdThread object from pool; if not, then create a new one. and register to pool.
	// 1. get global instance of RhdThreadProcessor.
	// 2. if not exists in current pool, then create and register a new one.
	// 3. increment calling counter.
	// 4. trigger the updated event, for the parent thread to start monitor the thread.
	static function RhdThread find(uvm_object o,string mn,string file,int line);
		string id = $sformatf("%s,%0d,%s",file,line,mn);
		RhdThreadProcessor proc=RhdThreadProcessor::getInst();
		return proc.search(o,id); // search in local process obj of given threads
	endfunction

	// automatic pulic api for the processor to find the thread by given id.
	function RhdThread search(uvm_object o,string id);
		if (!pool.exists(id)) begin
			RhdThread p=new(id,this,o);
			register(p);
		end
		pool[id].incr();
		updated.push_back(id);
		return pool[id];
	endfunction

	// Method to register a newly create RhdThread into this pool. And update the static fields for top module to add a new monitor thread of this RhdThread.
	function void register(RhdThread p);
		pool[p.id]=p;
	endfunction

	// A static method to wait the updated field to trigger.
	task waitUpdated(output RhdThread p);
		string id;
		wait(updated.size()>0);
		id=updated.pop_front();
		// updated.wait_trigger_data(id);
		// updated.reset();
		p = pool[id];
	endtask

	// The while loop monitor task, every time the updated event triggered,
	// will get the RhdThread and call a fork-join_none monitor task to detect state of that specific thread.
	task startMonitor();
		while (1) begin
			RhdThread p;
			waitUpdated(p);
			fork monitor(p); join_none
		end
	endtask

	// task to monitor the state of given RhdThread,
	// this task will not be killed, but normally finished when
	// the monitored thread been killed or finished. This monitor
	// task will only monitor when the thread been killed or completed.
	task monitor(RhdThread p);
		realtime t;
		p.await();
		t=$realtime/1ns;
		`RhdObjectInfo(p.container,$sformatf("%fns: %s",t,p.stateMessage()));
	endtask

	// The init process of this processor.
	// 1. find breakpoints options in ui, and setup the breakpoints array.
	function void init(RhdUserInterface _ui_);
		ui = _ui_;
		fork startMonitor(); join_none
	endfunction

	// api to detect in the member: breakpoints, if the given id and count matches the user specified breakpoint.
	function bool hasInjectedBreakpoint(string id,int count);
		string bkid = $sformatf("%s,%0d",id,count);
		if (ui.breakpoints.exists(bkid)) return true;
		return false;
	endfunction

	static RhdThreadProcessor globalInstance;
	// getInst -> RhdThreadProcessor, to return the gloal instance of this class
	extern static function RhdThreadProcessor getInst;
endclass

function RhdThreadProcessor RhdThreadProcessor::getInst; // ##{{{
	if (globalInstance==null) globalInstance=new();
	return globalInstance;
endfunction // ##}}}


`endif
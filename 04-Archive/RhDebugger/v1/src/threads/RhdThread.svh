`ifndef RhdThread__svh
`define RhdThread__svh

/*
This is a thread object that can be called for parallel thread control, which will be used at RhdThread features, for method call and separate thread monitoring.
*/

typedef class RhdThreadProcessor;
class RhdThread;

	// Fields
	// - p, the SV built-in process, it's private field.
	// - id, store the unique thread id, which is file,line,method name.
	// - count, the count of how this thread is being called.
	// - proc, set by where this thread is registered, indicates the thread processor
	// - container, the uvm object where the thread is created.
	local process p;
	string id;
	int count;
	RhdThreadProcessor proc;
	uvm_object container;

	// Create the new RhdThread in current thread, which will create a new SV process
	function new(string _id,RhdThreadProcessor c,uvm_object o);
		p = process::self();
		id = _id;
		count = 0;
		proc = c;
		container = o;
	endfunction

	// Return a string for printing the state message of current process. Format: `<file,line,method> is [been KILLED|FINISHED]`
	function string stateMessage();
		process::state s = p.status();
		string action = {(s.name()=="KILLED")? "been ":"",s.name()};
		string fmt = $sformatf("Thread(%s) is %s",id,action);
		return fmt;
	endfunction

	//Method to call the local SV process's await.
	task await();
		p.await();
	endtask

	// Function to get if this thread object has a breakpoint injected according to the  local api: 
	function bool hasBreakpoint();
		return proc.hasInjectedBreakpoint(id,count);
	endfunction

	// incr -> void, increment the count field by 1
	extern  function void incr;
endclass
function void RhdThread::incr; // ##{{{
	count++;
endfunction // ##}}}

`endif

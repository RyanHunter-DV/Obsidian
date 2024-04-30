`ifndef RhdBreakpointProcessor__svh
`define RhdBreakpointProcessor__svh
class RhdBreakpointProcessor;

	static RhdBreakpointProcessor globalInstance;

// public
	extern function  new ();

	// getInst() -> RhdBreakpointProcessor, get the global instance of this object
	extern  static function RhdBreakpointProcessor getInst();

	// init(RhdUserInterface ui) -> void, initialize the whole breakpoint processor, special for options
	extern  function void init(RhdUserInterface _ui_);

	// find(string fullname,string file,int line) -> RhdBreakpoint, 
	// static api to find a bk according to the given id(name,line), if not exists then create a new one.
	// 1. get id, check if exists in pool, if not build and register a new one.
	// 2. return
	extern static function RhdBreakpoint find(string fullname,string file,int line);

	// search(id,fullname) -> RhdBreakpoint, automatic api for find, there's only one global instance will be used to
	// search the pool, so global api find will actually call the search api
	extern  function RhdBreakpoint search(string id,string file);

	// activeCheck(RhdBreakpoint bk) -> void, check and active this bk if ui has matching id
	extern  function void activeCheck(RhdBreakpoint bk);

// private
	local RhdUserInterface ui;
	local RhdBreakpoint pool[string];
endclass

function void RhdBreakpointProcessor::activeCheck(RhdBreakpoint bk); // ##{{{
	int count = ui.matchedBreakpointId(bk.id);
	// once matched, then the count must >=0, 0 means trigger immediately,
	// or else trigger only when they have the same count.
	if (count >= 0) begin 
		bk.activate(count);
	end
endfunction // ##}}}

function RhdBreakpoint RhdBreakpointProcessor::search(string id,string file); // ##{{{
	if (!pool.exists(id)) begin
		RhdBreakpoint bk = new(id,file);
		pool[id] = bk;
		activeCheck(bk);
	end
	return pool[id];
endfunction // ##}}}

function RhdBreakpoint RhdBreakpointProcessor::find(
	string fullname,string file,int line
); // ##{{{
	string id = $sformatf("%s.%0d",fullname,line);
	RhdBreakpointProcessor proc=getInst();
	return proc.search(id,file);
endfunction // ##}}}


function void RhdBreakpointProcessor::init(RhdUserInterface _ui_); // ##{{{
	ui=_ui_;
endfunction // ##}}}

function  RhdBreakpointProcessor::new (); // ##{{{
	//TODO
endfunction // ##}}}

function RhdBreakpointProcessor RhdBreakpointProcessor::getInst(); // ##{{{
	//TODO
	if (globalInstance==null) globalInstance=new();
	return globalInstance;
endfunction // ##}}}

`endif
`ifndef RhdBreakpoint__svh
`define RhdBreakpoint__svh
class RhdBreakpoint;
/* Description,
	the breakpoint object, which can process breakpoint relative functions
*/
// public, place holder for public apis and fields

	string id; string file;

	// new(string id,string file) -> , store the id and file, initialize the count
	extern  function  new(string _id_,string _file_);

//TODO, require rhlib.svh
	int targetCount; bool enabled;
	// activate(int target) -> void, to activate the breakpoint by setting the enabled field to true,
	// and a targetCount will be set, once the targetCount equals the count, isTriggered api will
	// return true.
	extern  function void activate(int target);

	// isTriggered -> bool, return true when count equals to targetCount and enabled is true
	extern  function bool isTriggered();
	// incr() -> void, increment 1 of the count
	extern  function void incr();

// private, place holder for private apis and fields
	local int count;
endclass

function void RhdBreakpoint::incr(); // ##{{{
	count++;
endfunction // ##}}}

function bool RhdBreakpoint::isTriggered; // ##{{{
	if (enabled==false) return false;
	if (targetCount==count||targetCount==0) return true;
	return false;
endfunction // ##}}}

function void RhdBreakpoint::activate(int target); // ##{{{
	targetCount = target;
	enabled=true;
endfunction // ##}}}

function  RhdBreakpoint::new(string _id_,string _file_); // ##{{{
	id  =_id_;
	file=_file_;
	count=0;
endfunction // ##}}}



`endif
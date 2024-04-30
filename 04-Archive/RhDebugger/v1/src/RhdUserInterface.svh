`ifndef RhdUserInterface__svh
`define RhdUserInterface__svh

class RhdUserInterface ;
/* Description,
	a class to process the user options, which will be called through a static
	getInst api, and once it's been created, shall process the init operation
	automatically.
*/
	typedef RhdUserInterface this_t;

	// new() -> , the constructor, shall call this.init
	extern  function  new();
// public, place holder for public apis and fields

	// getInst() -> RhdUserInterface, get the static global instance
	// if not has this value, then new this object
	extern static function RhdUserInterface getInst();

	// from user options, the string is id index, while the element
	// is count index that user want to inject.
	int breakpoints[string];
	static RhdUserInterface globalInstance;

// private, place holder for private apis and fields

	// init() -> void, process the user input args
	// require the dpi from uvm
	extern local function void init();
	// injectBreakpoint -> void, get param from option, separate the id and counter
	// example: --.. uvm_test_top.env,line
	extern local function void injectBreakpoint(string param);

	// matchedBreakpointId(string id) -> int, if found the matched string id, then return the count that user want to
	// inject, else if not found, then return -1
	extern  function int matchedBreakpointId(string id);
endclass

function int RhdUserInterface::matchedBreakpointId(string id); // ##{{{
	int rtn=-1;
	if (breakpoints.exists(id)) rtn=breakpoints[id];
	return rtn;
endfunction // ##}}}

function void RhdUserInterface::injectBreakpoint(string param); // ##{{{
	string splitted[$];
	uvm_split_string(param,",",splitted);
	if (splitted.size() != 2) begin
		`uvm_error("RHDE",
			$sformatf("invalid param foramt for --inject-bk(%s)",param)
		)
		return;
	end
	// if previously defined by option, will overwirte it.
	breakpoints[splitted[0]] = splitted[1].atoi();
	return;
endfunction // ##}}}

function void RhdUserInterface::init(); // ##{{{
	int doInit=1;
	string s;
	do begin
		s = uvm_dpi_get_next_arg(doInit);doInit=0;
		case(s)
			"--inject-bk": injectBreakpoint(uvm_dpi_get_next_arg(doInit));
			default: continue;
		endcase
	end while (s!="");
endfunction // ##}}}

function  RhdUserInterface::new(); // ##{{{
	init();
endfunction // ##}}}

function RhdUserInterface RhdUserInterface::getInst(); // ##{{{
	if (globalInstance==null) globalInstance=new();
	return globalInstance;
endfunction // ##}}}


`endif
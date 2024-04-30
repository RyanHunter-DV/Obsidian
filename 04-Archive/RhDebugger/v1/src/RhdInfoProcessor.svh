`ifndef RhdInfoProcessor__svh
`define RhdInfoProcessor__svh
class RhdInfoProcessor;
/* Description,
	a central processor that can process specific log information used for debug only.
*/
	typedef RhdInfoProcessor this_t;
// public, place holder for public apis and fields

	static RhdInfoProcessor globalInstance;
	// getInst() -> RhdInfoProcessor, return a global instance of this object
	extern static function RhdInfoProcessor getInst();

	RhdUserInterface ui;
	// report(string msg,string file,int line) -> void, to report the given message at certain
	// hierarchy based log file
	extern  function void report(string msg,uvm_object o,string file,int line);
	// init(RhdUserInterface ui) -> void, initialize the printer,
	// 1. setup ui.
	// 2. create log home dir.
	extern  function void init(RhdUserInterface _ui_);

// private, place holder for private apis and fields

	// formatMessage(string msg,string file,int line) -> string, return formatted message to log
	extern local function string formatMessage(string msg,string file,int line);

	UVM_FILE pool[uvm_object];
	// register(uvm_object o,ref UVM_FILE fh) -> void, 
	// if object registered, then return the opened file, or register a new file by this object.
	extern local function UVM_FILE register(uvm_object o);

endclass

function void RhdInfoProcessor::init(RhdUserInterface _ui_); // ##{{{
	$system("mkdir -p logs");
	ui = _ui_;
endfunction // ##}}}

function UVM_FILE RhdInfoProcessor::register(uvm_object o); // ##{{{
	// UVM_FILE fh;
	if (pool.exists(o)) return pool[o];
	pool[o] = $fopen($sformatf("logs/%s.log",o.get_full_name()),"w");
	return pool[o];
	// TODO, for initialization when open a new log, initlog(fh);
endfunction // ##}}}

function string RhdInfoProcessor::formatMessage(string msg,string file,int line); // ##{{{
	realtime t=$realtime;
	string formatted = $sformatf("[%f@%s,%0d] %s",t,file,line,msg);
	return formatted;
endfunction // ##}}}

function void RhdInfoProcessor::report(string msg,uvm_object o,string file,int line); // ##{{{
	UVM_FILE fh;
	string formatted = formatMessage(msg,file,line);
	// TODO, tbd of this feature, if (suppressed()) return;
	fh = register(o);
	$fdisplay(fh,formatted);
endfunction // ##}}}

function RhdInfoProcessor RhdInfoProcessor::getInst(); // ##{{{
	if (globalInstance==null) globalInstance=new();
	return globalInstance;
endfunction // ##}}}

`endif
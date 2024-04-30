class RhdCore;
/* Description,
	This is the core of RhDebugger, the module of a tb to use this Rhd shall add:
	RhdCore::rhdStart() api at initial block.
*/
	static RhdCore globalInstance;

// public
	// rhdStart(), called by user Tb in initial block, to call all initial threads such as:
	// getInst of core
	// core.init
	extern static task rhdStart();

	// init, automatic task to init the core, which will do:
	// - ui process,
	// - RhdThreadProcessor create and init.
	// - RhdBreakpointProcessor create and init.
	extern task init;

	// getInst -> RhdCore, to get a static global instance of this class
	extern static function RhdCore getInst();


// private

endclass
function RhdCore RhdCore::getInst(); // ##{{{
	if (globalInstance==null) globalInstance=new();
	return globalInstance;
endfunction // ##}}}

task RhdCore::init; // ##{{{
//TODO, require details for ui
	RhdUserInterface ui= RhdUserInterface::getInst();
	begin
		RhdBreakpointProcessor bp=RhdBreakpointProcessor::getInst();
		bp.init(ui);
	end
	begin
		RhdInfoProcessor printer=RhdInfoProcessor::getInst();
		printer.init(ui);
	end
	begin
		RhdThreadProcessor tp = RhdThreadProcessor::getInst();
		tp.init(ui);
	end
endtask // ##}}}


task RhdCore::rhdStart(); // ##{{{
	RhdCore core=RhdCore::getInst();
	core.init;
endtask // ##}}}
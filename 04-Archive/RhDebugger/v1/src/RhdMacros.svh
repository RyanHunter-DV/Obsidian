`ifdef DISABLE_RHDEBUGGER

// empty define for place holder to skip real RhDebugger compile
`define RhdCall(method,args=());
`define RhdBreakpoint;
`define RhdInfo(message);
`define rhdline(expr) expr;


`else

`define RhdInfo(message) `RhdObjectInfo(this,message)

`define RhdObjectInfo(o,message) begin \
	string __file__=`__FILE__;int __line__=`__LINE__; \
	RhdInfoProcessor proc=RhdInfoProcessor::getInst(); \
	proc.report(message,o,__file__,__line__); \
end

`define RhdCall(m,args=()) begin \
	RhdThread p=RhdThreadProcessor::find(this,`"m`",`__FILE__,`__LINE__); \
	if (p.hasBreakpoint()) RhdProbeProcessor::dump("all"); \
	`RhdInfo(`"Calling method(``m``args)`"); \
	m``args; \
	`RhdInfo(`"Method(``m``args) called`"); \
end

// RhdThread is similar as RhdCall but it's for fork-join* parallel threads calling.
`define RhdThread(m,args=()) begin \
	RhdThread p=RhdThreadProcessor::find(this,`"m`",`__FILE__,`__LINE__); \
	if (p.hasBreakpoint()) RhdProbeProcessor::dump("all"); \
	`RhdInfo(`"Calling method(``m``args)`"); \
	m``args; \
	`RhdInfo(`"Method(``m``args) called`"); \
end



`define RhdBreakpoint begin \
	RhdBreakpoint bk = RhdBreakpointProcessor::find( \
		get_full_name(),`__FILE__,`__LINE__ \
	); \
	bk.incr(); \
	if (bk.isTriggered()==true) $stop; \
//	if (bk.isTriggered()==true) RhdProbeProcessor::dump("all"); \
end


// line debug
`define rhdline(expr) begin \
	`RhdInfo(`"start executing ``expr`"); \
	expr; \
	`RhdInfo(`"``expr executed`"); \
end

// condition macros {

`define rhdif(cond,branchcode) \
	if (cond) begin \
	`ifndef DISABLE_RHDEBUGGER \
		`RhdInfo(`"Condition(``cond) matched.`"); \
	`endif \
		branchcode; \
	end

`define rhdelse(branchcode) \
	else begin \
	`ifndef DISABLE_RHDEBUGGER \
		`RhdInfo(`"else branch matched.`"); \
	`endif \
		branchcode; \
	end

// to use if...else if... call like:
// `rhdif(xxx,xxx)
// else
// `rhdif(xxx,xxx)
//

// }

// loop macros {

// }

`define rhdwhile(cond,blockcode) begin \
`ifndef DISABLE_RHDEBUGGER \
	int __rhdwhile_builtin_index__ = 0; \
`endif \
	while (cond) begin \
	`ifndef DISABLE_RHDEBUGGER \
		`RhdInfo($sformatf( \
			"running while block, current index %0d",__rhdwhile_builtin_index__) \
		); \
	`endif \
		blockcode; \
	`ifndef DISABLE_RHDEBUGGER \
		__rhdwhile_builtin_index__++; \
	`endif \
	end \
end
`define rhddowhile(cond,blockcode) begin \
`ifndef DISABLE_RHDEBUGGER \
	int __rhdwhile_builtin_index__ = 0; \
`endif \
	do begin \
	`ifndef DISABLE_RHDEBUGGER \
		`RhdInfo($sformatf("running do-while block, current index %0d",__rhdwhile_builtin_index__)); \
	`endif \
		blockcode; \
	`ifndef DISABLE_RHDEBUGGER \
		__rhdwhile_builtin_index__++; \
	`endif \
	end while (cond);\
end
`define rhdforeach(loop,blockcode) begin \
`ifndef DISABLE_RHDEBUGGER \
	int __rhdwhile_builtin_index__ = 0; \
`endif \
	foreach (loop) begin \
	`ifndef DISABLE_RHDEBUGGER \
		`RhdInfo($sformatf("running foreach block, current index %0d",__rhdwhile_builtin_index__)); \
	`endif \
		blockcode; \
	`ifndef DISABLE_RHDEBUGGER \
		__rhdwhile_builtin_index__++; \
	`endif \
	end \
end
`define rhdfor(loop,blockcode) begin \
`ifndef DISABLE_RHDEBUGGER \
	int __rhdwhile_builtin_index__ = 0; \
`endif \
	for (loop) begin \
	`ifndef DISABLE_RHDEBUGGER \
		`RhdInfo($sformatf("running for block, current index %0d",__rhdwhile_builtin_index__)); \
	`endif \
		blockcode; \
	`ifndef DISABLE_RHDEBUGGER \
		__rhdwhile_builtin_index__++; \
	`endif \
	end \
end

`endif
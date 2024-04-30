# How to monitor a thread being killed?
*To evaluate the thread features: [[Specification#Feature description|Overview]]*
when a fork-join started, to create a process into a static pool, like:
```systemverilog
fork
	`RhdCallThread(taskA,args)
	`RhdLineThread(expr)
join_any
`RhdKill(disable); // if arg is disable, then use disable fork
`RhdKill(taskA);

// macro define
`define RhdThread(method,args) begin
	RhdThreads::processMonitor(process::self(),`__FILE__,`__LINE__);
	`RhdInfo("method thread called ....");
	method(args);
end

```
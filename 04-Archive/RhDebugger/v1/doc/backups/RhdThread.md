# Support switches for monitoring a thread
The thread control features can be enabled/disabled by a standalone option: `--stacktrace`
# Reports threads summarize
All registered threads but not finished or killed, shall be reported when simulation ends.
# Monitor fork-join threads
Can monitor the threads status issued through fork by a certain macro called by user. Once the thread status changed, a log shall be recorded in log file.
[[#Thread monitoring strategies]]
## Monitor threads that normally completed
- report the file,line position, simtime.
- report by RhdInfo.
```
source file:
fork
	`RhdThread(methodA(va,vb));
join
test.log:
10101000ns: thread(File.svh,110,methodA(va,vb)) start running
10200999ns: thread(File.svh,110,methodA(va,vb)) killed
---
10201000ns: thread(File.svh,110,methodA(va,vb)) finished
```
## Monitor threads that being killed.
report format similar as above.
## Get the process used by the thread
Optional process arg shall be available by users, so that users can use the process to kill, suspend and resume.
# Monitor fork-join_any threads
## Threads normally finished
## Threads being killed
Similar as in [[#Monitor fork-join threads]]
# Monitor fork-join_none threads
## Threads normally finished
## Threads being killed
Similar as in [[#Monitor fork-join threads]]
# Monitor a method threads
## Support displays a method call
example:
```
source file:
`RhdCall(methodA(args))
test.log:
FILE,123@1001: start call methodA
FILE,124@1001: methodA call finished
```



---
# Strategies


## Build a new thread object while calling RhdCall
By which can monitor the method threads.
```
RhdCall(call)
	fork begin
		RhdThread p = new();
		call;
		p.finish();
	end join
```

## summaize print
RhdThreads object in RhDebugger class, created when the debugger inited.
Provide finalize Api in RhDebugger, and explicitly called by uvm_test level when in final_phase, or report_phase.

## Thread monitoring strategies
### Build a process class for thread features
To build a process which will enhance the original process class. By which can monitor the specified threads.

```
fork
	`RhdThread(taskOrBeginBlock)
	`RhdThread(taskOrBeginBlock1)
join
---
`define RhdThread(m,p=__p)
begin
	RhdProcess p=new();
	taskOrBeginBlock...
	p.finish();
end

```

**fork-join_any strategies**

```
fork
	`RhdThread(A,gp)
	`RhdThread(B)
join_any
---
begin
	p=new()
	method...
	p.finish(); // for fork-join_any or fork-join_none, if finish not called, then means it been killed.
end
```
# Feature List
- support maximum 128 standalone resets.
- [[#standalone reference clock]]
- [[#configurable initialize]]
- [[#trigger reset action]].





# Feature Description

## standalone reference clock
The reset while triggered by user through a specific simulation time value, but for sync typed reset, it'll wait a posedge of the reset when the reset time reaches.
Each reset should be set a standalone reference clock through:
```systemverilog
rIf.refClk[0] = ...;
rIf.refClk[1] = ...;
```

## configurable initialize
By calling the UVC instance's init API, which can setup an initial reset once the domain enters run_phase.

## trigger reset action
Instead of typical reset sequence, the ResetGen UVC provides an API and a sequence let users to easily trigger the reset action.
'ResetGenSeq' is the sequence, by calling like:
```systemverilog
ResetGenSeq rs=new...;
rs.reset(index,time,sequencer);
```

## set interface path
While creating the UVC, shall set the interface path when the UVC is setting up.
```systemverilog
build ...
	rGen.setIfPath("tb.xxx...");
```

# Use Cases
## typical setup the ResetGen
*setup interface in tbTop*
```systemverilog
module top;
	...
	ResetGenIf rIf();
	rIf.refClk[0] = tbClk;
	rIf.refClk[1] = tbClk2;
	...
	initial uvm_config_db#(...)

	DUT udut (
		.iRstn0(rIf.oResetn[0]),
		.iRstn1(rIf.oResetn[1]),
		...
	)
```

*setup UVC*
```systemverilog
class Env ...
	ResetGen rGen;
	build...
		rGen= ResetGen::type_id::create(xxx);
		// resetIndex,initValue,initTime
		rGen.init(0,0,100ns); // if not set init, then the default init will not enabled.
		rGen.init(1,0,100ns); // if not set init, then the default init will not enabled.
```
*reset triggering during simulation*
```systemverilog
class Test ...
	run_...
		...
		ResetGenSeq rSeq=new...
		// resetIndex,resetTime,sequencer
		rSeq.reset(0,0,1000ns);
	end
...
```
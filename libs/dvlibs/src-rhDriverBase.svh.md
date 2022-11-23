# Source Code
**driver** RhDriverBase
**tparam** REQ=uvm_sequence_item,RSP=REQ
**tlm-ai** `reset RhResetTransBase resetI`
```
// extra code in write_reset, the input trans argument is _tr
resetState = _tr.state;
```
[[libs/dvlibs/src-rhResetTransBase.svh|RhResetTransBase]] is the reset transaction in [[libs/dvlibs/src-rhlib.sv|Rhlib]] package.
**field**
```
RhResetState_enum resetState;
```
RhResetState_enum is a type defined in [[libs/dvlibs/src-rhTypes.svh]].
**field**
```
process proc;
```
## mainProcess
**vtask** `mainProcess()`
**proc**
```
// override in sub classes
```

## build_phase
- init resetI imp
**build**
```
resetI = new("resetI",this);
```
## run_phase
**run**
```systemverilog
// extra run code here
fork
	__resetDetector__();
	forever begin
		wait(resetState == RhResetInactive);
		proc = process::self();
		mainProcess();
	end
join
```
## reset detection
**ltask** `__resetDetector__()`
**proc**
```systemverilog
forever begin
	wait(resetState == RhResetActive);
	if (proc.status != process::FINISHED) proc.kill();
	wait(resetState == RhResetInactive);
end
```
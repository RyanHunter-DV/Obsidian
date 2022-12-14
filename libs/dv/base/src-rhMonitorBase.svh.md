# Source Code
**monitor** RhMonitorBase
## support for monitoring reset actions
We'll use a report port to send the reset change event through the TLM port, after detecting by a subclass's API `waitResetStateChanged`
**tlm-ap** `RhResetTransBase resetP`
**field**
```systemverilog
RhResetState_enum currentResetState;
```
## build_phase
**build**
```
currentResetState = RhResetUnknow;
resetP = new("resetP",this);
```
## waitResetStateChanged
A virtual task to wait and get the changed reset state, this task will be overidden by sub-class.
**vtask** `waitResetStateChanged(output RhResetState_enum s)`
```systemverilog
// subclass should override this task
```

## run_phase
In run_phase, the monitor will spawn two parallel threads, one is for reset monitoring, which is common for all monitors that derived from this base, and the other thread is a mainProcess that can be used by subclasses
**run**
```systemverilog
fork
	resetMonitor();
	mainProcess();
join
```

## mainProcess
virtual task without doing anything
**vtask** `mainProcess()`
```systemverilog
// subclass should override this task
```
## resetMonitor
This is a forever task one run_phase started, this will wait the reset state changed by subclass, and then assemble a reset transaction and send through reset port.
**task** `resetMonitor()`
**proc**
```systemverilog
RhResetTransBase _t = new("initReset");
_t.state = currentResetState;
resetP.write(_t);
forever begin
	RhResetTransBase updatedTrans = new("updatedReset");
	waitResetStateChanged(currentResetState);
	updatedTrans.state = currentResetState;
	resetP.write(updatedTrans);
end
```
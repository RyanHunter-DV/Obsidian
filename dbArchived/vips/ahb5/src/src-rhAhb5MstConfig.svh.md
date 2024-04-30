# Source Code
**object** `RhAhb5MstConfig`

## interface controller
The interface controller which is an object class that sent from TB level. In this configure table, a base class named `RhAhb5IfControlBase` is declared here and will get from `RhAhb5MstAgent`.
**field**
```systemverilog
RhAhb5IfControlBase ifCtrl;
```
The interface controller is got by user set `interfacePath`
**field**
```systemverilog
string interfacePath;
```

## driving interface
### sendAddressPhase
**task** `sendAddressPhase(RhAhb5TransBeat b,int outstanding)`
**proc**
```systemverilog
bit busy = outstanding? 1'b1 : 1'b0;
ifCtrl.driveAddressPhase(b,busy);
```
reference: [[vips/ahb5/src-rhAhb5IfControlBase.svh#driveAddressPhase]];
### sendDataPhase
This task gets beat to drive data, and returns if interface detects error response, or else wait until the `HREADY` is high.
**task** `sendDataPhase(RhAhb5TransBeat b,output isError)`
**proc**
```systemverilog
if (b.write)
	ifCtrl.driveDataPhase(b,isError);
else ifCtrl.waitDataPhase(b,isError);
```
reference:
- [[vips/ahb5/src-rhAhb5IfControlBase.svh#driveDataPhase]];
- [[vips/ahb5/src-rhAhb5IfControlBase.svh#waitDataPhase]];

## getResetChanged
This task will the the interface controller's `waitResetChanged`
**task** `getResetChanged(output logic s)`
**proc**
```systemverilog
ifCtrl.getResetChanged(s);
```
[[vips/ahb5/src-rhAhb5IfControlBase.svh#getResetChanged]]


## getSignal
**func** `uvm_bitstream_t getSignal(string signame)`
**proc**
```systemverilog
return ifCtrl.getSignal(signame);
```
## waitCycle
call controller to wait cycle
**task** `waitCycle(int c=1)`
**proc**
```systemverilog
ifCtrl.sync(c);
```
## driveIdleBeat
This task to drive an idle beat of a master device, with specified cycle, the idle beat will last cycles according to the argument.
PS: arg os is short of outstandingData from driver.
**task** `driveIdleBeat(int cycle=1,int os)`
**proc**
```systemverilog
RhAhb5TransBeat beat;
sendAddressPhase(beat,os);
```
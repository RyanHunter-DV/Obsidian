# Source Code
**object** `RhAhb5MstConfig`

## interface controller
The interface controller which is an object class that sent from TB level. In this configure table, a base class named `RhAhb5IfControlBase` is declared here and will get from `RhAhb5MstAgent`.
**field**
```systemverilog
RhAhb5IfControlBase ifCtrl;
```

## driving interface
### sendAddressPhase
**task** `sendAddressPhase(RhAhb5TransBeat b,int outstanding)`
**proc**
```systemverilog
bit busy = outstanding? 1'b1 : 1'b0;
ifCtrl.driveAddressPhase(
	b.burst,
	b.trans,
	b.master,
	b.write,
	b.lock,
	b.excl,
	b.nonsec,
	b.addr,
	b.hsize,
	b.prot,
	busy
);
```
reference: [[vip-rhAhb5IfControlBase.svh#driveAddressPhase]];
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
- [[vip-rhAhb5IfControlBase.svh#driveDataPhase]];
- [[vip-rhAhb5IfControlBase.svh#waitDataPhase]];

## getResetChanged
This task will the the interface controller's `waitResetChanged`
**task** `waitResetChanged(output logic s)`
**proc**
```systemverilog
ifCtrl.getResetChanged(s);
```
[[vip-rhAhb5IfControlBase.svh#getResetChanged]]

## getHREADY
A function to get current HREADY value from interface, the return value is a logic.
## getHRESP
Get current signal value of HRESP from interface, the return value is a logic.
#TODO 

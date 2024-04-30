# Source Code
**object** `RhGpvConfig`

## fields
**field**
```systemverilog
string interfacePath;
RhGpvInterfaceControl ifCtrl;
```

## sync
To sync a specified clock cycle by the interface
**task** `sync(int cycle=1)`
**proc**
```systemverilog
ifCtrl.sync(cycle);
```
## driveVectorBit
This is the API to drive one bit of the vector in the interface, without consuming any time.
**task** `driveVectorBit(bit v,int pos)`
**proc**
```systemverilog
ifCtrl.drive(v,pos);
```
*relative links*
[[src-rhGpvInterfaceControl.svh#drive]]


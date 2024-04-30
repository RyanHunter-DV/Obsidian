# Source Code

**object** `RhGpvInterfaceControl`

## field
**field**
```systemverilog
virtual RhGpvIf vif;
```

## sync
The task to sync the clock of interface, currently only support one clock signal
**task** `sync(int cycle)`
**proc**
```systemverilog
repeat (cycle) @(posedge vif.clock[0]);
```

## drive
To drive one bit of the vector signal at the specific position
**task** `drive(logic v,int pos)`
**proc**
```systemverilog
vif.vector[pos] <= v;
```
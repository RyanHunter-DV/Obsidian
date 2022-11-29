The basic protocol for users to extend, provides several basic features and some of the constraints.

# Source Code
**object** `RhGpvProtocolBase`

## signal position register
**field**
```systemverilog
RhGpvSigPos_t signalMap[string];
```
**lfunc** `void __register__(string name,int s,int e)`
**proc**
```systemverilog
RhgpvSigPos_t pos= {s,e};
signalMap[name] = pos;
```

## initialize
**new**
```systemverilog
setupSignalMap();
```

## setupSignalMap
A virtual function override in sub class and called at super class for setting the signal map
**vfunc** `void setupSignalMap()`
```
```
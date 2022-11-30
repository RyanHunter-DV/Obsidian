The basic protocol for users to extend, provides several basic features and some of the constraints.

# Source Code
**object** `RhGpvProtocolBase`

## control the req/rsp
**field**
```systemverilog
bit reqEn,rspEn;
```
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

## reqStartCondition
**vfunc** `void reqStartCondition(ref RhGpvDriveObject dobj)`
**proc**
```
```


## translateToReq
This API to translate the getting vectors in `DriveObject` to the request transaction provided by user.
**vfunc** `uvm_sequence_item translateToReq(RhGpvDriveObject dobj)`
```
```

## waitReqStart
User API to specify the start conditions of a request monitor
**vtask** `waitReqStart(RhGpvDriveObject dobj,RhGpvInterfaceControl ifc)`
```
```
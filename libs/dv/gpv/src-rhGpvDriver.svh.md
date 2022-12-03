# Contents
- [[#mainProcess]]
- 
# Source Code
**driver** `RhGpvDriver`
**base** `RhDriverBase`
**tparam** `REQ=uvm_sequence_item,RSP=REQ`

## fields
**field**
```systemverilog
RhGpvProtocolBase protocol;
RhGpvConfig config;
```

## mainProcess
**vtask** `mainProcess()`
**proc**
```systemverilog
RhGpvDriveObject dobj=new("dobj");
seq_item_port.get_next_item(req);
protocol.translateReqToDriveObject(req,dobj);
__driveTheDriveObject__(dobj);
config.sync(1); // sync to next clock cycle.
seq_item_port.item_done(); // no response available for now.
```
*relative links*
- [[libs/dv/gpv/src-rhGpvDriveObject.svh]]
- [[libs/dv/gpv/src-rhGpvProtocolBase.svh#translateReqToDriveObject]]
- [[#driveTheDriveObject]] 

## driveTheDriveobject
The internal task to drive the translated `DriveObject` item through the config.

**task** `__driveTheDriveObject__(RhGpvDriveObject dobj)`
**proc**
```systemverilog
foreach (dobj.vectors[i]) begin
	foreach (dobj.bitsens[i][pos])
		if (dobj.bitsens[i][pos]) config.driveVectorBit(dobj.vectors[i][pos],pos);
	config.sync(1);
end
```
*relative links*
- [[libs/dv/gpv/src-rhGpvConfig.svh#driveVectorBit]]
- [[libs/dv/gpv/src-rhGpvConfig.svh#sync]]
- [[libs/dv/gpv/src-rhGpvDriveObject.svh]]

An object for condition controls. This object indicates the different conditions within one cycle, so it can be set like 1+ and/or conditions, like:
```systemverilog
RhGpvConditions c=new("condition");
c.init(ifc);
c.set(position,RHGPV_VALUE_CHANGE);
c.set(position,RHGPV_VALUE_CHANGE,RHGPV_COND_OR);
c.waitCondition(); // will wait until the set conditions triggered
```

# Source Code

**object** `RhGpvConditions`


## init
To setup the interface controller
**field**
```systemverilog
RhGpvInterfaceControl ifc;
```

**new**
```systemverilog
ifc = null;
eventID = 0;
```

**func** `void init(RhGpvInterfaceControl _ifc_)`
**proc**
```systemverilog
ifc = _ifc_;
```
## set
The `set` API will setup conditions for triggering, one condition matched will be triggered by a registered event. And one set of a condition will start a process but being suspended immediately, which will be resumed while calling the wait condition.
**field**
```systemverilog
process waiters[];
RhGpvCond_t conditions[];
uvm_event events[];
int eventID;
```
**func** `void set(RhGpvSigPos_t pos,RhGpvSigEvent_t e,RhGpvSigCond_t c=RHGPV_COND_NONE)`
**proc**
```systemverilog
fork
	begin
		process p = process::self();
		int eid = eventID;
		uvm_event e=new($sformatf("e_%0d",eid));
		waiters.push_back(p);
		conditions.push_back(c);
		events.push_back(e);
		p.suspend();
		__triggering__(pos,e,eid);
	end
join_none
eventID++;
```
[[Spaces/IC/libs/dv/gpv/src-rhGpvConditions.svh#triggering]]

## triggering
waiting for signals according to the input args, this thread will be blocked until the resume is called
**task** `__triggering__(RhGpvSigPos_t pos,RhGpvSigEvent_t e, int eid)`
```systemverilog

case (e)
RHGPV_VALUE_CHANGED: begin
	logic [pos.e:pos.s] lv; // #TODO this may have syntax issue
	lv = ifc.getSignal(pos.e,pos.s);
	while (lv === ifc.getSignal(pos.e,pos.s)) ifc.sync();
end
RHGPV_VALUE_RAISE: begin
	while(ifc.getSignal(pos.s,pos.s)===1'b0) ifc.sync();
end
RHGPV_VALUE_DROP: begin
	while(ifc.getSignal(pos.s,pos.s)===1'b1) ifc.sync();
end
events[eid].trigger();
```

## waitCondition
To resume all suspending threads to wait the condition being triggered
**task** `waitCondition()`
**proc**
```systemverilog
foreach (waiters[i]) waiters[i].resume();

fork
	// wait all 'OR' conditions
	foreach (conditions[i]) begin
		if (conditions[i]==RHGPV_COND_OR)
	end
	// wait all 'AND' conditions
	foreach (conditions[i]) begin
		if (conditions[i]==RHGPV_COND_AND) events[i].wait_on();
	end
join_any

```
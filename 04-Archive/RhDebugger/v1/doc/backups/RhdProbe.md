# Declare a probe
To enable the probe feature, users need to declare a variable through certain probe declaration syntax, which syntax will be encapsulated into a macro.
Users need to call `RhdCreateProbe(type,varname,default)` macro to create a new probe, which actually do: [[probeStrategies.canvas|probeStrategies]]
# Place a probe detector
The probe detector used to display the current probe value where a detector is placed, it's a default feature of RhdProbe. Besides, the probe detector also supports to override current probe value by user injections from sim command line. strategy: [[probeStrategies.canvas|probeStrategies]]
## Probe detector injected by command
## Support display different probe detector values.
## Support inject probe value in different types.
- enum type.
- bit vector type.
- 4-state vector type.

---
# Implementation strategies
## How to display different probe detector value?
```
call po.probeMessage() ->
TypeObject#(T) to;
$sformatf("value: %s",to.convertValueToString(value)); ->
```
use a type object to translate value in current probe into string, so that it can be directly printed by probe's probeMessage API.
- [x] Quest dependent: [[../../../quests-archived/Test for typename|Test for typename]]
## How to inject different type of probe values?

```
call po.override(ui) ->
value = to.convertStringToValue(ui.valueString); ->
type is int ...
```

**for int type, can call inject like:**
`xxx --probe-inject "path,h100,index"`
`xxx --probe-inject "path,d100,index"`
`xxx --probe-inject "path,o100,index"`
`xxx --probe-inject "path,b100,index"`

**for enum type, can call inject like:**
`xxx --probe-inject "path,EnumItem0,index"`
To achive this we can code like:
```systemverilog
Enum e = e.first;
while (index < e.num()) begin
	if (e.name()==injected) return e;
	e=e.next;
end
```

**for 4-state type:**
4-state inject must use binary format.
`xxx --probe-inject "path,b01x1,index"`

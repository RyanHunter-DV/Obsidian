It's the main necessary lib for calling the dump functions of vpi.
# Features
- [[dump a certain signal]]
- [[dump an interface]]

## dump an interface
This gonna dump a interface bundle like:
```
TIME 00000.0
utTB.vif.hclk    1'b0
utTB.vif.htrans  3'h0
...
TIME 00123.0
utTB.vif.htrans  3'h2
```
users can enable this feature simply by:
```cpp
// userProve.cpp
VpiInterfaceDump dumper(xxx);
dumper.start("utTB.vif",doubleScaledStartTime,doubleScaledEndTime);
```
[[Spaces/IC/rhVM/dvp-backup/src-vpiInterfaceDump]]





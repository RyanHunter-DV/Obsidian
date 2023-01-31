JIRA: https://ryanhunter30479.atlassian.net/browse/RHVM-8

# interface monitor, value dump

every clock cycle, when a signal changed, then its value will be dumped to a tracking file. This is the bottom mechanism to log/track the simulation.

-   macro guard of this code segment, when users want to shorten the compile time;  
-   plus args configurable so that it can be enabled without extra compile times;
	- +RHUDUMPER=InterfaceType0,InterfaceType1
-   time based, the clock will not be dumped;  
- 

_interface.log_
```
interface hierarchy: tb.udut_wrapper.axi_if0
TIME   SIGNAL   VALUE
0.0    sigA     3'hx
0.0    sigB     6'hx
0.0    sigC     8'hx
10.0   sigA     3'h2
10.0   sigB     6'h3
11.0   sigC     8'h0
```

_source methods_

```systemverilog
`define rhuLogicSignal(var,width)
	`ifndef RHUDISABLE
		`rhuLogicSignal_guard(var,width)
	`endif
`define rhuLogicSignal_guard(var,width)
	logic [width-1:0] var;
	always @(var) RhuDumper::record($sformatf("%m.dump"),`"var`",width,var,$time);

`define rhuDumperPostProcess()
	final begin
		RhuDumper::postProcess($sformatf("%m.dump"))
	end
interface axiIf;
	`rhuLogicSignal(sigA,32)

	`rhuDumperPostProcess() // process the dumper file of this interface
endinterface
```


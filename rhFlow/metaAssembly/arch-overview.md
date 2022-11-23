The metaAssembly is the flow to assemble meta design features into a verilog module. Currently supports verilog language only.
# Feature list
- [[#logical block assembly]], #TBD 
- [[#module instances]], #TBD 
- [[#signal auto declaration]], #TBD 
- assemble from `*.md` file, to generate `*.v` file;
- create a delibs for all features/modules stored;
- [[#specify target module]], #TBD 
- [[#signal automatically declared]]
- 

## logical block assembly
A specific bunch of logical operation can be defined as a design feature, and can be invoked while declaring a design.
The definition of a design feature can be like:
==strategy 1==
**feature** `featureName00`
```verilog
always @(posedge <clk> or negedge <rstn>) begin
	if (!<rstn>) begin
		<signal0> <= 8'b000;
	end else begin
		case(<signal1>)
			3'b000: <signal0> <= 8 'h0000_0001;
		endcase
	end
end
```
Invoke of a defined design feature can be like:
**feature** `featureName00(clk_i,rstn,decoded,encode)`

~~==strategy 2==
```ruby
defeature 'featureName00' do
	raw <<-EOF
always @(posedge <clk> or negedge <rstn>) begin
	if (!<rstn>) begin
		<signal0> <= 8'b000;
	end else begin
		case(<signal1>)
			3'b000: <signal0> <= 8 'h0000_0001;
		endcase
	end
end
EOF
end
## feature called like:
featureName00(clk_i,rstn,decoded,encode)
```
end strike through~~
Finally, we decide to use strategy1. The pre-defined features are stored in all md files.
## module instances
The module instances feature can automatically instantiate a module with automatically signal connection, except special connections specified by user.
**inst** `modulename instname[2]`
```
.port_i(special_connect),
.port2_i(partial_connect[4])
```
or:
**inst** `modulename instname`
```
```
or:
**inst** `modulename#(params) instname`
```
```
## signal automatically declared
special flags of a signal can be recognized by tool to declare it as a specific type:
- `*_w`, is a flag of a wire signal
- `*_i`, is a flag of input signal
- `*_o` for output
- `*_io` for inout
- `*_r` for reg
other signals that connected to a module instance but want to be consumed in current module, can be explicitly changed its connection while instantiation, like:
**inst** `module inst`
```
.port_i(port_w)
```
Then tool will automatically read the module and declare a wired port_w the same width as module declared.
Another way is to manually map the signals, for example:
if the signal0_w used in featureBlock would also like to connect to the inst's port0_i signal. By declaring as below can map the instantiated signal with current module used signal:
**connect** `inst[0].port_i signal0_w`
**feature** `featureBlock(signal0_w)`
**inst** `module inst[3]`
```
// suppose module has a port: port_i
```

#TBD 

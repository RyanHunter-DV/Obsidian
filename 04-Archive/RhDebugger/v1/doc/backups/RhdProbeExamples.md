# Generic probe example
Probe example:
```systemverilog
// declare
other code blocks...
begin
	`RhdCreateProbe(int,ia)
	`RhdCreateProbe(int,ib)
	
	// pos: uvm_test_top.enva.drva,110
	// by default here will display/log the current ia value,
	// if has override, then ia will be overridden
	`RhdProbe(int,ia)
end
```

**command to inject value**
```terminal
>> run --probe-inject "uvm_test_top.enva.drva.ia.110,10"
```
*This requires a command processor*

## Inject a driver
**declare place**
```systemverilog
class Driver;
	task mainProcess
		while (loop)
			get_next_item(req);
			begin
99				`RhdCreateProbe(int,localDelay,req.delay);
100				`RhdProbe(int,localDelay)
101				waitForDelay(localDelay);
			end

---
>> run --probe-inject uvm_test_top.drva.localDelay.100,20,3
		
```

## Inject for a test
```systemverilog
class Test;
	typedef bit[47:0] addr_t;
	task run;
		while (loop) begin
			`RhdCreateProbe(addr_t,addr,baseAddr);
			data = 'h2000;
			`RhdProbe(addr_t,addr);
			writeReg(addr,data,xxx);
		end
	end
---
>> run --probe-inject uvm_test_top.addr.49,'h1000_0000,3
```


# Inject a real typed value
Similar strategy with int value injection.

# Inject a 4-state typed value
#TBD 
```
--probe-inject "*,*,4'b01xz"
```
Currently no way directly transfer the 4-state value from command line to a variable value, need sv code to transfer internally.

# Inject a enum value
Can only support to inject in int type, and internal translated to enum type.


# Multiple probe inject option
The user option has multiple `--probe-inject` options.
*comments*
- index = 0 will override all times it called
- index = 1..n will override the Nth time it called
- create probe will also have an id in case the same local variable been declared multiple times. overide operation will search the nearest creation position.

format:
`run --probe-inject "pathid,value,index" --probe-inject "pathid,value,index"`
real example:
`run --probe-inject "uvm_test_top.iv.112,10,0" --probe-inject "uvm_test_top.iv.118,value2,3"`
`run --probe-inject "path.v.100,string,0"`

# Typical examples
## Probes for test building and debugging
*Scenario 1*





---
# Inject after a certain condition? #TBD 
Consider in next project version.
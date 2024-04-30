record next calling action, the method name, and the arg values.
This can also control invoking of a method by giving a dynamical run-time option, like:
```
class xxx;
	methoda
		`RhdCall(methodb(args))
endclass
run --call "<path>,1,<index>" // 1 to enable, which is default
run --call "<path>,0,0" --call "<path>,1,1" // disable at first time call, then enable later.
```

# Using examples
define example sketch.
```systemverilog
`define RhdCall(fn,fa) begin \
	`uvm_info("RHD",`"calling method (fn), args (`fa)`",UVM_NONE) \
	fn(fa); \
	end
```

# monitor procedures
- use Rhdline?

```systemverilog
// tested in vcs, which is feasible.
`RhdLine(
	seq_item_port.get_next_item(req);
	`RhdInfo($sformatf("getting request from test\n%s",req.sprint()))
	config.sync(req.delay);
	`RhdInfo($sformatf("start driving trans after delay(%0d)",req.delay));
	begin
		int duration=req.lpDuration;
		if (duration==-1) duration=config.genLpDuration();
		`RhdInfo($sformatf("generate lpDuration(%0d)",duration))
		//`RhdInfo($sformatf("active(%0d), 0->drive power off, 1->drive power up",req.active))
		if (req.powerOn==0) drivePowerOffRequest(req.ignoreQActive,duration);
		else drivePowerUpRequest(duration);
	end
	seq_item_port.item_done();
)
```
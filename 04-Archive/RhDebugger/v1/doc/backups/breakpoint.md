Can be call like a program debugging to add break point at certain line of the code. Usually at point that a RhdProbe been added.
Example:
```systemverilog
task RhQLpiDriver::processPowerControlTrans();
	`RhdCreateProbe(uvm_sequence_item,req)
	seq_item_port.get_next_item(req);
	`RhdProbe(req,)
	`RhdInfo($sformatf("getting request from test\n%s",req.sprint()))
	config.sync(req.delay);
	`RhdInfo($sformatf("start driving trans after delay(%0d)",req.delay));
	begin
		int duration=req.lpDuration;
		`RhdCreateProbe(int duration,req.lpDuration);
		if (duration==-1) duration=config.genLpDuration();
		`RhdProbe(duration)
		// `RhdInfo($sformatf("generate lpDuration(%0d)",duration))
		//`RhdInfo($sformatf("active(%0d), 0->drive power off, 1->drive power up",req.active))
		if (req.powerOn==0) `RhdCall(drivePowerOffRequest(req.ignoreQActive,duration));
		else `RhdCall(drivePowerUpRequest,(duration));
	end
	seq_item_port.item_done();
endtask

---
cmd:
## --breakpoint "HIER_PATH,<METHOD/THREAD>,<call index>"
// break at 10th call of this method
--breakpoint "uvm_test_top.env.drv.drivePowerUpRequest,10" 

---
logs:

file.v,110@11111: 


```

- breakpoint only available at where the RhdCall, or RhdThread called.
- breakpoint can be used to:
	- dump values, only variables declared by RhdProbe can be dumped.
	- inject a value, then continue running, only applicable for RhdProbe, and value will be flushed to it.

For first version, only supports simple types such as bit vector, int, real.

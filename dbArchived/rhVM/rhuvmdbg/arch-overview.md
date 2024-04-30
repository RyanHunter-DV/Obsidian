The entry for ==rhuvmdbg== methodology, easy for debug

# Features
- [[#support logging to separate files]]
- [[#choose the display verbosity]]


## support logging to separate files
This feature is opened by default, and in version 1.x, it is always enabled, cannot controlled by user.
All enabled rhudbg will be automatically logged into files based on its instance path.
Examples:
```systemverilog
class ADriver extends uvm_driver;

	function new(string name="xxx",uvm_component parent=null);
		// `rhudbg_register(ADriver)
	endfunction

	function void userFunction(int a);
		`rhudbg(MSGID,$sformatf("a is no: %0d",a))
	endfunction
endclass
// all displays in vcs_run.log will be suppressed to speed the simulation.
// information will be logged to a separated log file like: uvm_test_top.m_env.m_uvc.m_driver.log
// an example display:
// UVM_INFO @00, uvm_test_top.m_env.m_uvc.m_driver: a is no: 10
```

## choose the display verbosity
It supports to choose the verbosity by specific instance, component type, or specific id.
Examples:
```
+RHUDBG="uvm_test_top.m_env.m_uvc,ALL" // specify instance with all id
+RHUDBG="uvm_test_top.m_env.m_uvc,SPECIFIC_ID" // specify instance and id
+RHUDBG="ADriver,ALL" // #TBD, reserved for v2.x
+RHUDBG_ID="SPECIFIC_ID" // display all by id
```
The display will automatically use UVM_LOW, so need to set the uvm verbosity higher than low.



# reserved
## create objects with some of the auto debug information
This can be achieved by the `MDC` tool, that in building classes, the debug information will be automatically added to it.
#TBD 
[[mdc/v3/arch-requirements]]

## dump interface signals
#TBD 
```systemverilog
// tb
module utTB

	TestIf vif($sformatf("%m.%s",vif))

endmodule
interface TestIf(string hier);

	`rhudbg_signal(testOnehot,4)
	`rhudbg_signal(testBundle,32)
	`rhudbg_sigdump(hier,clock,reset)

endinterface

// log file:
// 
// TIME       SIGNAL                    VALUE
// 0.0        utTB.vif.a                 'hx
//

```
- interface should be created with a hierarchy from the TB level, used to display the hierarchy.
- declare signals through `rhudbg_signal` macro, which will declare the signal, and register it to the dump pool.
- `rhudbg_sigdump` will start the dump execution, for now, it only supports dumping signals from start till end.
- #TBD , call $system to execute the log_post_proc.py
- 


# Usage

## loading this add-on
*loading files by:*
```systemverilog
`include "rhuvmdbg.svh"
package userPackage;
	import rhuvmdbg::*;
endpackage
```
*setup and configuration*
```systemverilog
class AClass extends uvm_component;

	xxx new xxx
		`rhudbg_register(AClass)
	endfunction

	function userFunction();
		`rhudbg("TESTID",$sformatf("current a: %0d",a))
	endfunction
```
*command line options*
```
vcs/xrun/... +RHUDBG="uvm_test_top.m_env.m_uvc,TESTID"
or:
vcs/xrun/... +RHUDBG="uvm_test_top.m_env.m_uvc,*" // display all rhudbg in this instance to log file
or:
... +RHUDBG="uvm_test_top.m_env,TESTID0|TESTID1" // support multiple ID
```


## strategy for the report

*choose display verbosity by instance+specific id*


# Architecture
*while calling rhudbg_register*
- register current object handler and class type name into the debug pool
#TBD 
*while calling rhudbg*
#TBD 
*while giving command options*
- The first time calling the rhudbg_register, the debug pool will apply to process the incoming command options from the line.


# Source Files

[[rhVM/rhuvmdbg/src-rhuMacros.svh]]
[[rhVM/rhuvmdbg/src-rhuDebugPool.svh]]


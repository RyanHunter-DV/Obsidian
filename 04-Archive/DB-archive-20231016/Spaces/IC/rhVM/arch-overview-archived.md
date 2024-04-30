**notes link**
- [[Spaces/IC/rhVM/investigationNotes]]
**next step**
1. to build a more sufficient architecture to support this verification methodology(VM);
2. to setup a flow so that this VM can be auto generated with some of key user information, then build of UT level verification can be marked as completed;
**architecture link**
#TBD 
- [[Spaces/IC/libs/cpp/vpi/arch-overview]], vpilibs

# build for UT level ENV
[[rhVM/ut/arch-overview]]

RH Verification Methodology.
- [[rhVM-example]]

# Debug VPI Probe
DVP is short of debug vpi probe, which aims to debug easily through vpi actions so that no any recompilation is required. Current in investigation stage.
- [[Spaces/IC/rhVM/dvp-backup/arch-investigationNotes]]

# UVM debug information mechanism
This idea comes out since the DVP is not mature enough to replace the traditional debug methodology, so I figured out a way to enhance the traditional
UVM debug processes:
- use `+RHUVMDBG="<component/instance>"` to enable the debug logs for a specific component or instance.
- use a macro `rhuvmdbg(message)` to add information manually in a certain component
- use a macro `rhuvmdbg_register(xxx)` to pre-register a class to be of the RHUVMDBG mechanism.
*example*
```systemverilog
class ADriver extends uvm_driver;
	`rhuvmdbg_register(ADriver)

	function void userFunction(int a);
		`rhuvmdbg($sformatf("a is no: %0d",a)
	endfunction
endclass
// all displays in vcs_run.log will be suppressed to speed the simulation.
// information will be logged to a separated log file like: uvm_test_top.m_env.m_uvc.m_driver.log

```
#TODO, more features to be added later.
- signal dump feature can also apply for ==RHUVMDBG==
- 
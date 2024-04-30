DPI based C++ Verification Platform

*feature requirements*
- to support constrainted randomization.
- #TBD 




In the 1st version of rhVM, need to plan four kind of verification scope environment.
- ut level
- sub-ip level
- ip level
- soc level/sub-system level

# UT level
The unit test level, which is for a module test. The key components of this level are:
- the driver, a generic protocol vip is developed to drive signals for this level
- the monitor, getting information from the input/output signals
- the checker, check tests expection and the actual monitored value.

## driver
*example*:
```cpp
drvp->drive("signal","'hd"); // the value is a string that will be decoded ans translated to digital value at sv level
```
## monitor
## checker
## tests

## example
*tb level*
```systemverilog
interface TestIf;

	export "DPI-C" function xxxx
	export "DPI-C" task xxx
	function void drive(string signal,string value);
		logic [xxx] trueValue = __translateValue__(value);
		case (signal)
			"signalA": signalA = trueValue[3:0];
			xxx
		endcase
	endfunction 
	task sync(int cyc);
		@(posedge clock);
	endtask
endinterface
module tb;
	initial begin
		$tbStart("fromCmdLine");
	end
endmodule
```
*cpp level*
```cpp
namespace DPI {
	extern void drive(xxx,xxx);
};
void tbStart(char* testname) {
	// this tbStart is similar as the main(), to call runtest directly.
	runtest(testname);
}
void runtest(testname) {
	Test tp = new ...
	tp->setup();
	tp->run(); // timeslot0: call driver-monitor-...
	tp->finish();
}
#include 'rhVM_dpi.h'
using namespace DPI;
class Driver {
	void drive () {
		DPI::drive(signal,value);
	}
}
class Monitor {
	void collect() {
		DPI::getsignal
		...
	}
}
class Test {
	void run() {
		while (xxx) {
			timeslot->start();
			driver->run();
			monitor->run();
			checker->run();
			timeslot.next()
		}
	}
}
```

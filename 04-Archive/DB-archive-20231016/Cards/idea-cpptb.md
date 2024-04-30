#idea

```cpp
class Test {
	void testSim() {
		env.config ...
		seq.start(env.mst.drv) ...
	}
}
```

```cpp
class AhbDriver {
	void mainProcess() {
		waitSequence(); //
		if (notBusy) {
			driveControlPhase(delay,value); // vpi_put_value
		} else {
			driveControlPhase()
		}
		driveDataPhase(delay+1,value); // vpi_put_value
		setBusy();
		nextLoop();
	}
}
```

# conclusions
- use cpp as an accessory way to support systemverilog simulation, like:
	- signal/variable value tracking
	- DPI functions
	- #WIP 
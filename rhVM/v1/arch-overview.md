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
driver->drive("signal","'hd"); // the value is a string that will be decoded ans translated to digital value at sv level

```
## monitor
## checker
## tests


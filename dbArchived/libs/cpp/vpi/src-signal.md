This is a `Signal` class that can reflect the 4 state of signal value, and the bit wise of the signal.
# Using examples
```cpp
Signal s("HADDR",21,SIGNAL_VALUE_X);
s.set(0x23);
s.set(SIGNAL_VALUE_1,0,3);
s.set(SIGNAL_VALUE_X,3,4);
p_signal_value* val = s.get();
// val is of format:
// val[0] = 0 -> 0
// val[1] = 1 -> 1
// val[2] = 2 -> X
// val[3] = 3 -> Z
```
# Features
- [[#define 4-state value]]
- [[#user specified vector length]]


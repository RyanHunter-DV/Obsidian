# Source Code
**header**
```cpp
#include <rhstring.h>
#include "vpi_user.h"
#include "stdlib.h"


```

**header**
```cpp
class VpiInterfaceDump {
```

## initialize
#TBD 

## start
*procedures of start*
- get all signals within this `hier`
- set value changed callbacks for all those signals
- a callback function should be defined,
	- if last triggered time same with current time, then puts the signal and value to file directly
	- if last triggered time not same, then update the time, and puts a new time and signal to file.
	- [[libs/cpp/src-rhqueue]], a queue is required for processing multiple line contents.

**header**
```cpp
public:
	void start(const char* hier,double stime,double etime);
```
**body**
```cpp
VpiInterfaceDump::start(const char* hier,double stime,double etime) {
	String* hierp = new String(hier);
	
}
```
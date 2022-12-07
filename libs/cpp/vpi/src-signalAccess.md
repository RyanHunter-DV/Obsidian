The signalAccess feature used to access signals, such as interfaces or normal signals of a module.
**relative links**
- [[libs/cpp/vpi/src-signal]]
- [[libs/cpp/src-rhstring]]
- 

# contents
- [[#Using Example]]
- [[#Features]]
- [[#Source Code]]

# Using Example
## typical usage
To use the signalAccess feature, should first include the head file of signalAccess, then create a signalAccess class with given tb, like:
```cpp
UserTB tb(xxx);
SignalAccess sa(tb);
sa.drive('hierachicalSignalName',3);
sa.drive('hier',vec);
...
```
## interface usage
There's some requirement that maybe a driver will need to drive different signals in a certain interface scope, the signalAccess provides features like that, by specifying the certain scope, and corresponding driving will be done within that scope, like:
```cpp
SignalAccess sa(xxx);
sa.scope('utTB.vif');
sa.drive('HADDR',0x23);
sa.drive('HWRITE',0x1);
...
```
## get signal value
to get the signal value immediately at this time.
example:
```cpp
SignalAccess sa(xxx);
PLI_INT32 v = sa.get('utTB.vif.HADDR');
p_vpi_vecval val = sa.get('utTB.vif.HWRITE',vpiVectorVal);
```
# Features
- drive hierarchically
- [[#drive values]]
	- drive bit values within 32-bit
	- drive bit value exceed 32-bit, #TBD 
	- drive X/Z value, #TBD 
- [[#get values]]
	- get bit typed value within 32-bit
- [[#set scopes]]
- [[#wait values]]
- [[#clock sync]], #TBD 

# Source Code

**header**
```cpp
#include <rhstring.h>
#include "vpi_user.h"
#include "stdlib.h"

```
**header**
```cpp
class SignalAccess {
```
## fields
**header**
```cpp
private:
	String* __scope;
```
## initialize
This class is being initialized with a giving const char scope, which will be stored into the internal string. Whenever the drive called, if scope has item, then the driving will happened within the scope.
**header**
```cpp
public:
	SignalAccess(const char* scope="");
```
*steps of this initializer*
- create a new String pointer, with the given scope value.
**body**
```cpp
SignalAccess::SignalAccess(const char* scope) {
	__scope = new String(scope);
}
```

## drive values
### public: drive int variable
This API can drive all variables as of type int, which means the bits within 32 bits
currently support signal name type:
- const string
- String pointer #TODO
**header**
```cpp
public:
	void drive(const char* name,int val);
```
**body**
```cpp
void SignalAccess::drive(const char* name,int val) {
	String* sig=new String((*__scope)());
	if ((*sig)!="") {sig->append(".");}
	sig->append(name);
	s_vpi_value vpiVal;
	vpiVal.format = vpiIntVal;
	vpiVal.value.integer = val;
	__drive__(sig,&vpiVal);
	delete sig;
	return;
}
```

### internal drive core
The drive core is an internal function that calls the bottom level VPI function to drive specific signal value
**header**
```cpp
private:
	void __drive__(String* sig,p_vpi_value val);
```
**body**
```cpp
void SignalAccess::__drive__(String* sig,p_vpi_value val) {
	vpiHandle vpiSig = vpi_handle_by_name((*sig)(),NULL);
	s_vpi_time _t;
	_t.type = vpiNoDelay;
	_t.high=0;_t.low=0;
	vpi_put_value(vpiSig,val,&_t,vpiNoDelay);
	return;
}
```
## set scope
Users can manual change the scope after creating the `SignalAccess`, and can also clear the scope by reset it to empty string "".
### public: scope
**header**
```cpp
public:
	void scope(const char* val);
```
**body**
```cpp
void SignalAccess::scope(const char* val) {
	(*__scope)=val;
}
```
## get values
### get int typed values
The `get` API can get directly from a specific named hierarchy, or by given signal name. If current scope is set, then the given argument will be treated as a signal name, else if the scope is empty, then the given argument is a full hierarchical name.
*relative links*
- [[#public: scope]]
- 
**header**
```cpp
public:
	int get(const char* name);
```
**body**
```cpp
int SignalAccess::get(const char* name) {
	String* sig=new String((*__scope)());
	if ((*sig)!="") {sig->append(".");}
	sig->append(name);
	s_vpi_value vpiVal;
	vpiVal.format = vpiIntVal;
	__get__(sig,&vpiVal);
	return vpiVal.value.integer;
}
```
### internal get core
the internal get core function will directly process with vpi functions, and return the value from vpi pointer.
**header**
```cpp
private:
	void __get__(String* sig,p_vpi_value val);
```
**body**
```cpp
void SignalAccess::__get__(String* sig,p_vpi_value val) {
	vpiHandle vpiSig = vpi_handle_by_name((*sig)(),NULL);
	vpi_get_value(vpiSig,val);
	return;
}
```
## wait values
To wait until a signal equals a specific value, current support int values.
The wait mechanism been achieved by:
- register a callback
- use dead loop while to wait the specific callback value got
- jump out of the loop if target value triggered.
### wait int values
**header**
```cpp
public:
	void wait(const char* name,int target);
```
**body**
```cpp
void SignalAccess::wait(const char* name,int target) {
	__setupWaitCallback__(name,target);
	String* s = new String(name);
	if ((*s)!="") {s->append(".");};s->append(name);
	VpiCallback vc = VpiCallback((*s)());
	vc.setup(cbValueChange,target);
	while (!vc.triggered());
}
```
[[libs/cpp/vpi/src-vpiCallback]], #TBD 

## clock sync
by calling of `sync`, to wait specific clock cycles in a specific clock signal
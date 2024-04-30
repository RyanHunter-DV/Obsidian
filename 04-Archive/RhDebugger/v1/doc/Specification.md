The main entry of RhdDebugger project.
# Feature description
## Support user interface process
- Support probe options, to inject an override value.
- Support debugger enable/disable switch, to enable/disable the whole debugger features.
- Support RhdInfo options, to partially enable/disable the logging features.
More details in [[04-Archive/RhDebugger/v1/doc/backups/UI|UI]]
## Support RhdProbe feature, can probe a class field or local variable:
- to display the value where a macro `RhdProbe(xxx)` is called;
- dynamically inject value into the position where has a `RhdProbe(xxx)` macro, through sim option;
More details in [[RhdProbe|RhdProbe]]
## Support RhdInfo feature
- by which can suppress screen debug information, and log into component hierarchy based log file.
- enable certain level logging feature, in soc level, if all log are enable, it'll be too large log files.
More details,[[RhdInfo|RhdInfo]]
## Support thread controlling features, monitor a task or fork-join thread is running or not.
- Support monitor when a fork-join thread normally finished.
- Support monitor when a fork-join thread been killed, when killed log info.
- Support monitor a method been called, finished, this is enabled only when stacktrace is enabled.
- Support thread control, can inject a skip to avoid invoking a certain thread without recompiling.
More details in [[RhdThread|RhdThread]]


## Method thread monitoring feature
call RhdCall(method...), by which can create a new thread object to monitor it. Used specifically for method calling threads.
[[RhdThread#Monitor a method threads]]



---
# Strategy
## RhDebugger setup flow
To enable the RhDebugger features, a top object shall be created at test level, in build phase, which is a RhDebugger, called by: `RhDebugger rhd=new();`
Details: [[setupflow.canvas|setupflow]]
# Architecture
## Object descriptions
- RhDebugger, main container package.
- UserInterface, user option processor, require RhOptions project.
- RhdProbe, RhdProbes
- RhdProcess, the process wrapper, used for RhdThread control.
## Major steps
Represents in source code.

## How to distinguish the develop code and publish code?
In Soc scope, each IP's env maybe well developed so they need publish stage while in Soc env, which may need develop stage, how to distinguish that?
1. unique macros differentiate with ip and soc?
2. run option, which still need to compile full code, but will not execute that part.

```systemverilog
// soc
`define RhdPublished(scope)
	`RhdPublished_``scope


---
	`ifdef `RhdPublished
		...
---
ip package:
	`define RhdPublished RhdPublished_Ip0

```
example:
[[../../../../../../Attachment/images/Pasted image 20230810142321.png]]

---
# Archived

#TBD , following feature may be deleted since it's not much meaningfull.
- Support RhdCall feature, used for calling a method by a specific macro of some extra behaviors:
	- logging report information, notify users that a function being called;
	- dynamically block the method call, #TBD cannot figure out a typical scenario for this feature.
	- 


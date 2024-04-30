# Using Cases

- to check a certain thread/task/function is called or not?
	- 
- 


# Features

## display values
*message report when a certain value of variable/net has changed*
#TBD 

## dump values
[[rhVM/dvp/arch-vpiDump]]
*dump signals from a certain hierarchy when a event occurred*
#TBD 
dump separate signal information like:
```
SIGNAL: utTB.vif.hresetn
TIME          VALUE
000000.0      1'bx
000010.0      1'b0
001000.0      1'b1
```
dump signal bundle like:
```
TIME 00000.0
utTB.vif.hclk    1'b0
utTB.vif.htrans  3'h0
...
TIME 00123.0
utTB.vif.htrans  3'h2
```

*dump an abstraction of signal bundle*
#TBD 

## value injection
### inject signal values
This might use a `force` to force the interface/signals on a design or port

#TBD 


### inject variable values
by using vpi_put_value, it's very easy to se a variable value to specific variable, which no need to use force, can support:
- when detect a certain hierarchy of a variable's value changed, then to inject a certain hierarchy value
	- static values are easy achived;
	- how about dynamical values? such as in a task/function of a class?

==using cases==
- temporarily modify a value in a component class to fastly check if the coming issue can pass



details: [[rhVM/dvp/arch-valueInjection]]


#TBD 


## display threads
#TBD 

*display information when a certain thread is triggered*
- certain thread means specify that thread by name
- 


#TODO *task/function tracing stack*
```systemverilog
Verilog Stack Trace:
0: task test.t1 at ./test.v:17
1: initial block in test at ./test.v:3
```

# feature list
- builtin add, if user not specified.
	- new, build_phase, ...
	- uvm_driver of a driver, if no explicitly specify the base of a class.
- builtin fields/methods of svclass, users not need to specify it.
	- uvm_component_utils ...
- 

# major programming flow
By calling of `optimizeDataBase` from upper level, the `SmartBuilder` will do actions like:
- detect builtin methods of `SVSupport` for every svclass, if no builtin, assemble default builtins
- detect the base/params of a class, if is type of driver/monitor etc, but no explicity base, then add a default base.
- add default builtins for class, such as uvm_component_utils etc ...

# initialize
#TODO 
# optimizeDataBase
#TODO 

Macro file for rhuvmdbg

# Source Code

## macro for display information
### debug register
To register this class into the debug pool. A global debug pool will be created the first time a register action happens. The pool object is here:
[[rhVM/rhuvmdbg/src-rhuDebugPool.svh]]

**field**
```systemverilog
`define rhudbg_register(ctype) \
	begin \
		RhuDebugPool _pool_ = RhuDebugPool::getGlobalPool(); \
		_pool_.register(this,`"ctype`"); \
	end
```

### debug print
**field**
```systemverilog
`define rhudbg(id,msg) \
	begin \
		RhuDebugPool _pool_ = RhuDebugPool::getGlobalPool(); \
		_pool_.processDisplayID(id,this); \
		`uvm_info(id,msg,UVM_LOW) \
	end
```
*links*
- [[rhVM/rhuvmdbg/src-rhuDebugPool.svh#processDisplayID]]
- 
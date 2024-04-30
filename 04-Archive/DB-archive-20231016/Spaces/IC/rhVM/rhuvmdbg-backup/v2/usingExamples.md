# debug print
source:
```
class xxx
	func xxx
		`debug(message)
```
log:
```
UVM_INFO xxxx 
```

*debug a while loop condition*
```
while (xxx) begin
	if (condition) `rhudbgLine($sformatf("matched condition"),lineExpression)
	`rhudbg($sformatf("check current variables"))
	waitOneCycle();
```
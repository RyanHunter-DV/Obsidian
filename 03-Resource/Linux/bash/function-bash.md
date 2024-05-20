# function declaration grammar

```bash
function name() {
	commands
}
# or
function_name() {
	commands
}
# or
function_name() {commands;}
# call function with parameters
function_name 'arg0','arg2',...
```

## function parameters
![[Pasted image 20240520095949.png]]

# variables & scopes
**local**, setting the variable scope: `local v=xxx`

# return
![[Pasted image 20240520101243.png]]

# function used as a command
while a function is defined in login shell, then the function can be used as a terminal command.
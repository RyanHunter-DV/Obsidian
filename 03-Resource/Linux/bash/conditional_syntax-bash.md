
```bash
# format
if [ expression ]; then # attention the expression between [], must leave with a space char

fi
# example
function v() {
	if [ $# -gt 0 ]; then # attention that $# > 0 is redirect the $# into 0 file.
		echo "nvim $*";
	else
		echo "nvim";
	fi
}
# or and operation
if [ expression ] && [ exp2 ]; then
fi
if [ exp ] || [ exp2 ]; then
fi
if [ exp0 && exp2 || exp3 ... ]; then
fi
```
# compare two values
the traditional `>,<,...` symbols are not typically used to compare two numbers, instead, using the `-gt,-lt,-eq` operations, like:
```bash
if [ 1 -gt 3 ]; then # -lt, -eq is similar
	...
fi
```

# use `((xxx))` as conditional judgement
![[Pasted image 20240520112444.png]]
![[Pasted image 20240520112505.png]]

# initialize
## qualifiers initial
All methods has a `extern` qualifier by default. For more qualifiers in initialization, will be extracted from the input mark. Supported marks are [[arch-SVClassFeatures#declare manual methods]].
qualifiers supported: `virtual`, `extern`, `static`, `local`, which has position orders. Qualifier comes from the input mark argument when initialize, it'll be extracted from the mark, and the default `extern` mark will be added automatically.

## prototype initial
The SVMethod class supports two types of the constructor, one is string typed prototype while the other is array typed. Both prototype will stored as an Array in this class field `@prototype`. So input of the string will be translated to an array like:
```ruby
@prototype = [];
if arg0.is_a?(String)
	@prototype << arg0;
else
	@prototype.push *arg0;
end
```
Another argument of this constructor is `container`, which is a string of the class name where this method locates in. This `container` will simply be stored in the `SVMethod` as a field.
## split return type of a function
for function type, the first word from arg0 is a return type, which should be splitted from the arg0
## init builtin methods
For some of the built-in methods, the initialization flow can be a bit different. Check in `initialize` like:
```ruby
if __isBuiltIns__(mk)
	p = createProtoForBuiltIns(mk);
	addBodyForBuiltIns(mk);
	mk= changeBuiltInMarkToCommonMark(mk);
end
__initQualifiers__(mk);
__initMethodType__(mk);
__initPrototype__(p);
```

# addBody
The addBody API simply adds multiple procedures into current method. This API can be called multiple times so that the body of the svmethod can be added separately.
# show prototype/procedure codes
Two APIs are provided to give the sv source code of a svmethod's prototype and procedure.
## prototype
The prototype is kind like:
```systemverilog
extern virtual function void funcName(arg0,arg1 ...);
// it can be multiple lines like:
extern virtual function void funcName(
	arg0,
	arg1,
	...
);
```
That kind of prototype are given by API `prototype` in `SVMethod`. The return type of `prototype` is an array that suitable for one line prototype or multiple line prototype, format is like:
`["line0","line1"]`

## body
The `body` API can return an array of this method's procedures, the array is like:
`["\tline0;","\t\tline2;","line3;"]`
The body information should contain both the head and the end of a formal SV method definition, such like:
```systemverilog
function void TestClass::testFunc(
	arg0,
	arg1,
	...
);
	line0;
	line1;
endfunction
```

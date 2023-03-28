This page describes features, examples and strategies to build up systemverilog class by the UVMB tool.

# Features
- support methods declaration and body procedures.
- support [[#field declaration]].
- support [[#parameter definition]].
- support build file, and add file macro.
- support [[#specify base class name]].


# Examples

*user source*
```ruby
svclass :name do
	base 'basename'
	param 'PN=V'
	tparam 'T=V'
	scalar 'type','name'
	scalar 'int','ia','10'
	darray 'fieldtype','name','indextype'
	task ... do
		<<-CODE
		-...
		-...
		CODE
	end
	func ... do
		<<-CODE
		-...
		CODE
	end
end
```
*target sv*
```systemverilog
class name extends basename;
	function new ...
	function ...
	task ...
endclass
```



# Strategies
## specify base class name
by using the 'base' command, which declared within the `ruby::SVClass`, can specify which base class to use when generating the code, if users want assign the parameter declared in current class to base, shall specify the base class name like `BaseClass#(P,P2)`.

## parameter definition
Supports type parameter by `tparam` command and parameter by `param` command, like: `param 'pname=value'`, `tparam 'pname=value'`.
This also supports multiple parameter definition by giving multiple string typed arguments like: `param 'pname0=value0','pname1=value1'`.

## field declaration
This command used to declare different fields, the 'field' is a common command suitable for all fields, besides, `ruby::SVClass` also supports specific field declaration like: `scalar`, `sarray`, `darray`, `queue` etc.

### scalar
This command used to declare the single dimension variables, such as `int`,`bit` etc. These kind of variables only has type, name and default arguments, like:
```ruby
scalar 'int','ia','10'
scalar 'uvm_object','obj','null'
scalar 'Driver#(AW,DW)','drv'
scalar 'time','st'
```
### sarray
### darray
### queue

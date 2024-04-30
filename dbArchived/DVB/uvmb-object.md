This page describes features, examples and strategies to build up uvm object by the UVMB tool.

# Features
- support object UTILS and the fields.
- derived from SVClass, has all SV class features. [[uvmb-svclass]]
- 

# Examples

*user source*
```ruby
uvm_object :name do
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
class name extends uvm_object;
	int ia = 10;
	...
	`uvm_object_utils_begin(name)
		`uvm_field_xxxx(ia,UVM_ALL_ON)
	`uvm_object_utils_end

	function new ...
	function ...
	task ...
endclass
```


# Strategies



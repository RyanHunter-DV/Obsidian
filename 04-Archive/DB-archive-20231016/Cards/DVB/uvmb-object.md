This page describes features, examples and strategies to build up uvm object by the UVMB tool.

# Features
- support [[#object and field utility]].
- support [[#setup constructor]].
- derived from `ruby::SVClass`, has all SV class features. [[uvmb-svclass]]

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
## object and field utility
Object utility is verify easy to achieve, just to setup the utility codes during `finalize` method.
For field utility, UVM supports different field utility, according to input element type, index type, and field type, to setup the different field utility.
Field will be setup through: [[uvmb-svfield]].
To setup field utility like:
```ruby
class SVField
	def uvmft
		return 'aa_int_string'

end

class SVObject
	def fieldUtilitySetup
		@fields.each do |f|
			%Q|`uvm_field_#{f.uvmft}(#{f.name},UVM_ALL_ON)|
		end
	end
end

```

## customize field flags
Users can add their custom field flags for a specific field by calling like:
```ruby
uvm_object :name do
	scalar 'int','ia','10'
	fields.ia.flag= 'UVM_ALL_ON|UVM_NOCOMPARE'
end
```

## setup constructor
For object, to setup the constructor in finalize, by creating a new function with no return type.

# Example to declare a class field
*scalar types*
```ruby
uvm_object ... do
	field 'int a=10'
	field 'int b'
	field 'bit [3:0] bc'
	field 'ClassObj#(P) p'
end
```

*mult-dimensional types*
```ruby
uvm_object ... do
	field 'string aa[int]'
	field 'string que[$]'
	field 'bit[3:0] da[]'
	field 'ClassObj#(P) sa[10]'
end
```
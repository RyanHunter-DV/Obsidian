# Features
- inherits from the `ruby::UVMComponent` class, [[uvmb-component]].
- 
# Strategies
## setup default base class
the default base class is `uvm_driver#(REQ,RSP)`, so as the parameter name, so if user didn't specify any extra commands. Tool will
automatically create a driver like:
```systemverilog
class <classname>#(type REQ=uvm_sequence_item,RSP=REQ) extends uvm_driver#(REQ,RSP);
```

## disable default parameters
To disable the default setting, users can call command with:
```ruby
uvm_driver :name do
	custom :head do
		# calling custom will delete the default REQ,RSP params in class
		tparam 'TP=AxiTrans','RSP=RspTrans'
		base 'uvm_driver#(TP,RSP)'
	end

	scalar ...
	task ...
end
```


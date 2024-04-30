# Features
# Strategies

## setup default base class
the default base class is `uvm_sequencer#(REQ,RSP)`, so as the parameter name, so if user didn't specify any extra commands. Tool will
automatically create a sequencer like:
```systemverilog
class <classname>#(type REQ=uvm_sequence_item,RSP=REQ) extends uvm_sequencer#(REQ,RSP);
```

## disable default parameters
To disable the default setting, users can call command with:
```ruby
uvm_sequencer:name do
	custom :head do
		# calling custom will delete the default REQ,RSP params in class
		tparam 'TP=AxiTrans','RSP=RspTrans'
		base 'uvm_sequencer#(TP,RSP)'
	end

	scalar ...
	task ...
end
```
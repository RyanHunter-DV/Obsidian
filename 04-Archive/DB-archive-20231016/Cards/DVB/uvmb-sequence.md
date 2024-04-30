# Features
- field/method definition features from [[uvmb-svclass]].
- support [[#body command]].
- support [[#constraint command]].
# Strategies
## body command
For building sequence, the body command is necessary for users to add their custom body executions like:
```ruby
uvm_sequence :name do

	body do
		<<-CODE
		-....
		CODE
	end

end
```

## constraint command
This command used for users to setup the constraints of this sequence, like:
```ruby
uvm_sequence :name do
	rand 'int','a'
	constraint :extname do
		<<-CODE
		-...
		-if (a==0) {b inside {[0:10]};}
		CODE
	end
end
```
## random field
The rand feature only supported by some of `int`, `bit` kinda variables, so use `rand` to specify a random scalar field, which will first call `scalar` and then add qualifier to that field.

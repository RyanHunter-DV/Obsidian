# Features
- inherits from `ruby::UVMComponent`, [[uvmb-component]].
# Strategies
## setup key components
- build driver, can declare, setup driver with simple user commands.
- build monitor, can declare, setup monitor with simple user commands.
- build sequencer, can declare, setup sequencer with simple user commands.

### driver
The `driver` command being used in `ruby::UVMAgent` to setup a driver, according to the 'is_active' value. Block information is being used to setup driver configs, example:
```ruby
uvm_agent :name do
	driver 'RhAhb5MstDriver' do
		<<-CODE
		-deviceMode(RHAHB5_MASTER);
		-fieldDelay= 10;
		CODE
	end
end
```

### monitor
Similar with `driver` command.
### sequencer
Similar with `sequencer` command.


# Relations
[[uvmb-driver]]
[[uvmb-monitor]]
[[uvmb-component]]

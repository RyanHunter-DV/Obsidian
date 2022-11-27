# Features

## define configurable components
in a `config`, it can need a component with different configuration packs, such as simulation options in different `config`. So that it can build up a project easier.
Using examples:
```ruby
config :testConfig do
	need :aComponent,:config => :configSuit
	...
end
```

# setup tests
To run a test with UVM, a testname is required, besides, the config name should be specified by the test definition.
like:
```ruby
test :exampleTest do
	config :testConfig
	uvm 'testname','options'
end
```

#TODO 

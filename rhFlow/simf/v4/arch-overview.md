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

## easy dependencies
For a component, if it needs another component, then simply call by `require`, instead of the original `need` operation. So a component will be defined like:
```ruby
component :RhTestComp do
	require :RhBaseComp, :version => 'v1.0'
end
```
The dependencies are being checked (sync, clean, download etc) by a set of sub command of the  simf tool, like: `simf -s`, so that the simf tool will check sync while publishing the components.
*component sync*
by using of sync, it will sync with tree versions. Currently only support sync command.
Once a component requires another component, it will then publish the required component first, before publishing current component.

## redefine a component
A component can be:
- a sv package, with many includes specified in that sv package, #MARKER
- 


#TODO 

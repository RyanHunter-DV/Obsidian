# simf
The simf is just a shell to call the `MainEntry` so that this part of code will keep as before.

# MainEntry
The main entry of the flow tool, it will load the option first, select running mode next and evaluate the expression next.
## major steps
the tool supports following major operations:
- sync up all imported components only
- evaluation the input actions only
- evaluation the input actions with sync up
## evaluation commands
during run phase of `MainEntry`, the evaluation command will be directly eval in the `MainEntry` class, like:
```ruby
def run
	sig = eval @option.evaluation
	returnWithSig
end
```
by that way, if the evaluation command is `xcelium.build(:configName)`, will call the xcelium plugin.

## load plugin
Before start running of `MainEntry`, it need to load all plugins in the `lib/plugins.rb`, such as:
```ruby

class MainEntry
	def plugin n,blk
		@@context.loadPlugin 'plugin/'+n+'.rb'
		@@context.configPlugin blk
	end
	def loadPlugins
		require 'plugin/plugin-configs.rb'
	end
end
```
Examples of plugin-config.rb
```ruby
plugin 'xcelium' do
	xlm = Xcelium.new()
	self.define_instance_variable('@xcelium',xlm)
	self.define_singleton_method 'xcelium' do
		return @xcelium
	end
end
```

## load root.rh
The root.rh is the root node file that specified by the `ENV['SIMF_ENTRY']`, Those kind of files are used to declare components, configs, tests and the top evaluation context, which is called a context (or package). All evaluation commands been executed within that top context. A context is a collection of components and can be evalauted by user eval commands, attention that a component cannot been evaluated. The context is being called like:
```ruby
def context n
	if MainEntry.context != nil
		raise Exception ...
	end
	MainEntry.context = Context.new();
end
def run
	@@context.instance_eval @option.evaluation
end
```


# built-in plugins
## xcelium
A plugin flow support from build to sim with xcelium tool, it requires many of basic flows such as build.
provides APIs for users:
- build(:configName)
- compile(:testName)
- run(:testName)

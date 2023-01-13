
# requires


# features
The main entry of the flow tool, it will load the option first, select running mode next and evaluate the expression next.
- support evaluation the input actions with sync up
- support sync up all imported components only

# initialize
# run
the tool supports following major operations:
- [[#setup debug mode]]
- [[#load root.rh]]
- [[#linkContext]]
- [[#sync up required components]], #TBD 
- [[#loadPlugins]]
- [[#finalizeContext]]
- [[#evaluation commands]]
- 

## finalizeContext
After loading the root.rh, and linking the context, the next is to finalize the context, process body definitions in: context->test->config->component

*finalize context*
all contexts' body will be evaluated first

*finalize test*

*finalize component*



#TBD 
## setup debug mode
load and setup debug component, [[rhFlow/simf/v4/Debug]]

## linkContext
After loading the root.rh, the context should be declared in that kind of files, so there should be a valid context in `MainEntry`.
A context is created like:
```ruby
context :name do
	component :a
	component :b
end
```
The context is just a collection of variant components for now, it's declared by root.rh set, and in `MainEntry`, it will only load the `lib/context.rb` at the top of the `lib/mainentry.rb` file. After loading the root.rh, then `MainEntry's @@context = Context.get`.

## evaluation commands
during run phase of `MainEntry`, the evaluation command will be directly eval in the `MainEntry` class, like:
```ruby
def run
	sig = eval @option.evaluation
	returnWithSig
end
```
by that way, if the evaluation command is `xcelium.build(:configName)`, will call the xcelium plugin.

## loadPlugins
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



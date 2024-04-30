required through the `rhload` by [[MainEntry]].
# features
- [[#provide the global API context]]
- [[#declare a Context class]]


# provide the global API context
- create a Context object recorded in `Context` class;
- The code block will be evaluated by the created object



# declare a Context class

Context is the top level of all config, test, and components, all can be searched within a specified context, like:
```ruby
component :A do
	required 'ctx.componentA'
end
```
So that multiple context will be defined by a single simf run. But only will be evaluted in the chosen context.

## commands supported by context
*component*
declare a component instance, declare the relation that the component belongs to.

## finalize
it will first get objects that instantiated by current context, mapping the relations between context and components;
#TBD 
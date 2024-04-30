This is the SV component builder, it derives from `ruby::UVMObject`
# Features
- support [[#common phases]].
- support [[#component constructor]].
- support [[#customize phases]].
- 
# Strategies
## component constructor
The `ruby::UVMObject` has a built-in constructor, which is for object building, but in component, this should be setup separately and replace the object's constructor.
## common phases
To setup phases like build, connect, run.
## customize phases
To setup APIs for additional phase actions like:
```ruby
build do
	<<-CODE
	-...
	-...
	CODE
end
```
According to above example, setup `build`, `connect`, `run` to add extra codes, but users can also to disable phases like:
```ruby
uvm_component :name do
	disable :method,'build','connect'
end
```
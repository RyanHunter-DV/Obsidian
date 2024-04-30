each project has only one root.rh entry. But can have multiple context,  component, config, and test.
a context is like a namspace constraint, a specific config/test/component can belong to a specified context, each of above should belongs to at least one context. The tool will first allocate the entries in the imported dir, then allocate entry of current project.
# nested imports
An imported project can have a import dir, contents within the import dir decided by the files in `__be__/env.config`
loading project can have 2 major steps, loading imports and loading local. So it can be:
```ruby
project = Project.new();
project.loadall
```
# load project
to load project, is to load `*.rh` files from root.rh to node.rh, all files are used to declare context, component, config and test. So the first step is to load those files. Then second step is to parse those files, which means to:
- find all context, evaluate all contexts' body
	- for `component :a, :as=>:b`, to find the original component by name in `ComponentPool`, and copy the object to current context, and instantiated it by `:as` name. Attention, components from imported projects cannot be instantiated into current context
	- for `config`, `test`, are similar
*example*:
```ruby
context :CA do
	component :AC
end
component :AC do |ctxt|
	if ctxt==A
		xxx
	end
end
```
- for test
	- test will have group, for easy operation, so that one specific test group can be set to a specific context.
# config context for imported project
```ruby
component :AC do |xxx|
	required :CB, :ctxt=>'va'
	required 'uvm.standard'
	required 'rhlib.types'
	required 'rhlib.component'
end
```


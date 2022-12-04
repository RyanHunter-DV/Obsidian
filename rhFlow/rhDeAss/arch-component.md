# Feature
## instance feature of a component
by calling the `component` API, can instantiate a component into a design, like:
```ruby
component 'IPComponent', :as => 'ip0'
```
## declare a component
a bunch of features, interfaces or adhocs can be declared in the component, like:
```ruby
component 'IPComponent' do

	interface RhAhb5If.slave, :as => 'ahb'
	adhoc 'ppb_oh_o',:out,8

end
```
- [[rhFlow/rhDeAss/arch-interface]]
- [[rhFlow/rhDeAss/arch-adhoc]]

## specify type of a component
A component can be as of a verilog module or a bunch of feature collections, by declaring the `type` key word in component, can specify this component is for what kind of usage:
```ruby
component 'TestComponent' do
	type :vmod ## or type :block
end
```
- `vmod`, specify this component as a verilog module
- `block`, specify this component as a logical block, which can be instantiated by other `vmod` or `block` typed component.
## define a block typed component
*example*:
```ruby
component 'BlockA' do |*args|
	type :block
	hready = args[0]
	htrans = args[1]
	sel_oh = args[2]
	
	f__bitAnd2, hready,htrans[0],sel_oh[2]

end
```
## instantiating features and other components
A component supports to instantiate a feature or block typed component, by directly passing the current component's ports to the block component/feature:
```ruby
component 'TestComponent' do
	type :vmod
	c__BlockA ppb.HREADY,ppb.HTRANS[0],ppb_sel_oh_o
end
```

# latest sketch
![[Pasted image 20221204211219.png]]
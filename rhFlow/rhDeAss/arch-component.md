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
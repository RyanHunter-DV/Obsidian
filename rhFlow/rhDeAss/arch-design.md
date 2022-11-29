# Features
- [[#declare a design]]
- [[#configure manager]]

## declare a design
A `design` concept is the top component of the project to be assembled, only one design is allowed to be generated at the ==rhDeAss== flow.
declare a design like:
```ruby
design 'designName' do
end
```

## configure manager
The configure manager is a concept that contains all configures for all the sub components, interfaces and connections.
There's a global API called `configm` by which users can declare a configure manager tool to set all different configurations for this design.
*example*:
```ruby
design 'designName' do
	component 'IPComponent', :as => 'ip0'
	component 'IPComponent2', :as => 'ip1'
	configm 'manager0' do
		#TBD 
	end

end
```
#TBD 

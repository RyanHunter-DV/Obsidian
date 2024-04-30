# Features
## declare an interface
The interface is being declared with some of the format, like:
```ruby
interface 'RhAhb5If' do
	port 'HCLK',:in,1
	port 'HRESETN',:in,1
end
```

## instantiate interface
using example:
```ruby
interface 'RhAhb5If', :type => :slave, :as => 'ppb'
```

## define a modport
a modport is typically a pre-defined method to create a direction of a bunch of ports that can be used easily in interface instances in a component, like:
```ruby
component 'subIP' do
	RhAhb5If.receive ## this will declare in/out of ahb interfaces as a slave
end
```
ref: [[rhRVCore/arch-overview#rhRVC_IFetcher#interface description]]

*other example links*
- [[rhRVCore/arch-overview]]
- 
## calling port
ports are invoked by `feature` or connected to a module typed `component`.
*relative link*
[[rhFlow/rhDeAss/arch-port]]

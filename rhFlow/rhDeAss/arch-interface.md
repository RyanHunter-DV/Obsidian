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
## calling port
ports are invoked by `feature` or connected to a module typed `component`.
*relative link*
[[rhFlow/rhDeAss/arch-port]]

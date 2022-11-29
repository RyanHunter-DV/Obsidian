# Methodology Concepts & basic Examples
- [[#design]]
- [[#component]]
- [[#feature]]
- [[#interface]]
## design
A design is the top concept of a project. The assembly flow will run start from the specified design level.
A design will contain many of the components it required, connections and configurations for instantiating those components, interfaces etc.
typical example:
```ruby
design 'designTop' do

	## components instantiated in this design
	component 'IPComponent', :as => 'ip0'
	component 'rhCore-v1', :as => 'cpu0'
	
	## connections of these instantiates
	#TBD 

end
```
*relative links*
[[rhFlow/rhDeAss/arch-design]], #TBD 

## component
A component is kind of a sub module or hierarchy of the project, it's used to create hierarchical designs. A component has the properties like:
- `type`, used to specify the type of the component is a logical block(:block) or a verilog module (:vmod);
- `view`, view like :rtl or :shell, used to generate interface only or with internal component/features.
- #TBD 

*example*:
```ruby
component 'IPComponent' do
	type :vmod # or type :block, or type :ip
	view :rtl
	interface RhAhb5If.slave, :as => 'ppb'
	adhoc 'ppb_sel_oh_o',:out,8

	feature 'bitAnd2', ppb.HREADY,ppb.HTRANS[0],ppb_sel_oh_o[2]

	...

	component 'SubIpComponent', :as => 'sip0'

	#TBD for connect
	connect do
		sip0.signal_o.connect(ppb.HREADY)
	end

end
```

## feature
`feature` is a bunch of logical operations that ecapsulated in design libs and can be called by components. A `component` can assemble a bunch of features as a large logical block for higher level of components.
*example:*
```ruby
feature 'bitAnd2', *opts do 
	verilog "#{opts[0]} = #{opts[1]} & #{opts[2]}"
end
```
for more examples, refer to:
[[libs/de/rhDeAss/arch-overview#feature files]]
## interface
use to declare a bunch of ports, #TBD 

*relative links*
- [[#port]]
## port
`port` used to declare signals with in/out/inout attributes, example:
```ruby
port 'portname_o',32
port 'portname2_i',1
```
*relative link*
[[rhFlow/rhDeAss/arch-port]], #TBD 



The port has following features:
- the in/out/inout attributes determined from the name of the port, which means
	- `*_w`, is a flag of a wire signal
	- `*_i`, is a flag of input signal
	- `*_o` for output
	- `*_io` for inout
	- `*_r` for reg
- the second arg when declaraing a port is the width of the port.
- define `[]` method which is a partial selection API.
- connect API, 
- #TBD 

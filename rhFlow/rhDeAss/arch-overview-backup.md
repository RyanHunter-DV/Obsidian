# Contents
- [[#feature list]]
- [[#architecture]]
- 
# feature list
- [[#logical feature block]]
- [[#nested feature declaration]]
- [[#variable feature declaration]]
- [[#module instances]]
- [[#signal automatically declared]]
- [[#module declaration]]

## logical feature block
A bunch of logical operation can be declared as feature block. By declaring a bunch of code within a specific feature declaration file. This file will be taken in by a tool for generating RTL code.
The file is like:
```ruby
feature :featureName00 do |*s|
	codes << "#{s[0]} = #{s[1]} & #{s[2]};";
end
```

## nested feature declaratin
A nested feature usage is supported, like:
```ruby
feature :featureName00 do |*s|
	codes << "#{s[0]} = #{s[1]} & #{s[2]};";
end
feature :featureName01 do |*s|
	a = 'tmp'
	featureName00 a,s[1],s[2]
	featureName00 s[0],s[3],a
end
featureName01 'a','b','c','d'
```
## variable feature declaration
variable feature means some of similar features can be declared through a specific variable, like:
```ruby
10.times do |index|
	next if index < 2;
	feature "bitAnd#{index}".to_sym do |*s|
		l = "#{s[0]} = #{s[1]} & #{s[2]}"
		iindex=2
		while (iindex < index) do
			l+=" & #{s[iindex+1]}"
			iindex += 1
		end
		codes << l
	end
end
bitAnd2 a,b,c
bitAnd3 a,b,c,d
```
## module instances
The module instances feature can automatically instantiate a module with automatically signal connection, except special connections specified by user.

```ruby
modinst 'modulename','instname' do
	connect '.port_i(rgn_ihit[0])'
end
```
or:
```ruby
modinst 'modulename','instname'
```
or:
```ruby
modinst 'modulename#(param)','instname' do
	connect '.port_i(rgn_ihit[0])'
end
```
## signal automatically declared
special flags of a signal can be recognized by tool to declare it as a specific type:
- `*_w`, is a flag of a wire signal
- `*_i`, is a flag of input signal
- `*_o` for output
- `*_io` for inout
- `*_r` for reg
other signals that connected to a module instance but want to be consumed in current module, can be explicitly changed its connection while instantiation, like:

```ruby
modinst 'modulename','instname' do
	connect '.port_i(rgn_ihit_w)'
end
```
Then tool will automatically read the module and declare a wired port_w the same width as module declared.
Another way is to manually map the signals, for example:
if the signal0_w used in featureBlock would also like to connect to the inst's port0_i signal. By declaring as below can map the instantiated signal with current module used signal:
#TBD , this feature remained as an optional feature
```ruby
connect 'instname.port_i','rgn_ihit_w'
modinst 'modulename','instname'
```

## module declaration
A module declaration file is to call many feature blocks and other modules as instances, connect those signals correctly and declare its own input/output.
By assembling the module declaration file, feature files and other module files can finally generate a standard RTL module file.
module file example:
```ruby
module 'modulename' do

equalCompareWithMask('addr_match_w','ahb_haddr_i','base_addr_i','region_mask_i')
	bitAnd3('region_hit_w','sub_enable_w','region_comp_en_i','addr_match_w')
	inv('sub_enable_w','region_perm_srd_i[sr_sel_w]')

	modinst 'modulename','instname' do
		connect '.port_i(rgn_ihit[0])'
	end
	
end
```

# architecture
before establishing the architecture, create an example first.
#TBD 
# Example
```ruby
feature 'name' do

	## input?
	## output?
	
end
```

# Definition

inputs while declaring a feature:
- a block with multiple procedures
- the name inputed as a string arg
- 

outputs by declaring a feature:
- no explicit output of this feature declaration
- but calling the newly defined method which is named as `f__<featurenName>` will be able to generate the verilog code

by declare a feature, following actions will be done:
- create a ruby class: `Feature`, and registered into `FeaturePool`
- generate a ruby method with the name of the declared feature
- the block inputed while declaring this feature will be part of the newly created method, so that mean every time invoke this feature will call the block actions declared in the feature
- generate verilog code according the actions in declaration block, this been done at the last step of the new created method

while calling the defined feature, which will experience:
- particular operations ...
- the code block defined while declaring the feature
- generate string array, which contains lines of verilog code of that feature, by calling of `verilog`, which is defined in a `Component`, to push the input cnts to the `Component` ruby class field

# Feature
- the feature is the meta unit that generates the RTL code finally;
- feature can be invoked by component only, nomatter `:block` or `:vmod` typed component
- All these concepts available for rhDeAss only
- by calling `verilog` at the end of the `f__<featureName>` method, the raw contents can be publish to its container.

## configurating a feature
- input/output is different and will be specified by the caller
- other configures, such extra string contents to assemble this feature
*example of configure:*
```ruby
feature 'combineMux3', *opts do
	"#{opts[3]} = <=%config%>?#{opts[0]} : <=%config%>?#{opts[1]}:#{opts[2]}"
end
# using of above feature:
f_combineMux3 s0,s1,s2,o do
	config "grantedPC_w==3'b001"
	config "grantedPC_w==3'b010"
end
```
# description
A feature is kind of a logical block that will realize a certain functionalities. It's inputs and outputs and description should be extremely explicit to users, so that can be easily refered by them.
So the feature can be like:
```ruby
feature 'namedFeature' do
	input a,b,c
	output d,e
	descp 'this feature achives xxxx'

	## real action code block, which is not necessary for users
	xxxx

end
## calling a feature can be:
blockA.porta.to namedFeature.a ## auto creating a feature instance
```

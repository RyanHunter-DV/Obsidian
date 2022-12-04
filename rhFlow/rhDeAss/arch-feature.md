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

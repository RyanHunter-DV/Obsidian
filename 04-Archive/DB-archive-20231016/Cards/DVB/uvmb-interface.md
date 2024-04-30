# Features
- Support [[#port declaration]].
- Support [[#field declaration]].
- 
# Strategies
## interface declaration
Use global interface command to declare SV interface, like:
```ruby
interface :name do
	...
end
```
By using the global 'interface' command, an interface can be declared. Within the global 'interface' command various of internal commands then can be added.

## port declaration
Use same `ruby::Port` class, features same as [[uvmb-module#ports declaration]].
But in interface declaration, the 'input', 'output' port declared will be used only for declaring, like:
```systemverilog
interface name(input logic[1:0] port,...)
```

## field declaration
Declare signals and variables, similar with SV classes' fields declarations, [[uvmb-svclass]].
## methods declaration
Support method declaration features, similar with methods in [[uvmb-svclass]], but methods are declared not like class which has 'extern' features.
## always block
#TBD 
## initial block
#TBD 
## other codes
For future version. #TBD 

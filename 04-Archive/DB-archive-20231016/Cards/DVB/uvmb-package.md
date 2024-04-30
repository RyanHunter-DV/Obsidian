For SV package
# Features
- Support [[#built-in imports and includes]].
- Support [[#package declaration]].
- Support [[#import command]].
- 


# Strategies

## package declaration
Use global 'package' command to declare an SV package, like:
```ruby
package :name do
	...
end
```

## import command
Support import within the package declaration block, example:
```ruby
uvm_package :name do
	import 'Packg::*'
end
```

## include command
This command used to include files, for specific usage, the include can appeared in package or without package like:
```systemverilog
`include "file1.svh"
package Packagename;
	`include "file0.svh"
endpackage
```
To achieve this, need to support including within the package or out of the package, user source config:
```ruby
uvm_package :name do
	include 'filename.svh',:external
	include 'filename2.svh' # default is internal, within the sv package
end
```

## built-in imports and includes
Support built-in imports of uvm information by this package command.
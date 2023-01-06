# Features

## define configurable components
in a `config`, it can need a component with different configuration packs, such as simulation options in different `config`. So that it can build up a project easier.
Using examples:
```ruby
config :testConfig do
	need :aComponent,:config => :configSuit
	...
end
```

# setup tests
To run a test with UVM, a testname is required, besides, the config name should be specified by the test definition.
like:
```ruby
test :exampleTest do
	config :testConfig
	uvm 'testname','options'
end
```

## easy dependencies
For a component, if it needs another component, then simply call by `require`, instead of the original `need` operation. So a component will be defined like:
```ruby
component :RhTestComp do
	required 'Rhlib.RhBaseComp', :version => 'v1.0'
end
```
The dependencies are being checked (sync, clean, download etc) by a set of sub command of the  simf tool, like: `simf -s`, so that the simf tool will check sync while publishing the components.
*component sync*
by using of sync, it will sync with tree versions. Currently only support sync command.
Once a component requires another component, it will then publish the required component first, before publishing current component.

## redefine a component
A component can be:
- a sv package, with many includes specified in that sv package;
- a bunch of verilog files, collected by the command `fileset`;
- c++ files with specific Makefile compile command;
### sv package
A component in simf can be a bunch of files with one sv package inside, like:
```
aPackage.sv
filea.svh
fileb.svh
dira/filea.svh
...
```
those files should be specified within the component block like:
```
component :APackage do
	fileset 'aPackage.sv',:filelist=>true
	include '*.svh','dira/*.svh'
end
```
files specified by `include` will be published to out-anchor/APackage/...
but will not appeared on any of the filelist.
files specified by `fileset` will be listed in the filelist by default, if `:filelist` arg is false, then it will not appeared in the filelist.
incdir will be automatically added to the filelist if the file exists in the filelist.
### verilog files
It can be a bunch of rtl files or the testbench component, like:
```
component :RTL do
	fileset '*.v' ## if no extra ordering required
	## or
	fileset '*.sv'
end
```
attention that fileset will not search files recursively, so if you have files within different folders, just to specify it manually like `dira/*.v`
### c++ files


### multiple component in one project tree
we can only sync with one project at a time, but a project may contain multiple components, so how to manage syncing components in this way?
every component will have a root package, it can only been declared at the root of a project like:
```
package :vips do
	component :RhAhb5Vip
	component :RhAxi4Vip
end
```
then requiring a component will be like: `required 'vips.RhAhb5Vip'`, and call of sync will sync up all required component's root package.
if a component has no package, which means this project only has one component, then we can treat it as a root component, like:
```
component :uvm do
	xxxx
end
component :a do
	required 'uvm', :version=>'0.1'
end
```
## special EDA options for a component
some of the component need specific options, so a component should support that like:
```
component :uvm do
	compopt :xlm, '-nouvmautocompile'
	simopt :xlm, '-sv_lib xxx'
	fileset 'dpi/uvm_dpi.cc'
	fileset 'uvm.sv'
end
```
## builtin components/packages
*uvm package* #TBD 
A uvm will be a standalone package listed in GitHub tree, with:
```
component :uvm do

end
```

*Rhlib*
#TBD 



# Architecture
[[rhFlow/simf/v4/architecture]]


#TODO 

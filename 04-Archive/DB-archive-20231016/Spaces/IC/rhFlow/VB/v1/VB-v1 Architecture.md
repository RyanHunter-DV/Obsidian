# Feature List
- [[#building vip through user configurations]]

## building vip through user configurations
using global different commands to build different components. global commands supported for building vip are:
- [[#command 'driver']]
- [[#command 'monitor']]
- [[#command 'seqr']]
- [[#command 'trans']]
- [[#command 'agent']]
- [[#command 'env']]

### command 'driver'
A global command to setup information of driver component, multiple driver command supported, but user should be able to make sure the naming/path should not conflict.
used to create a driver.
### command 'monitor'
Command to setup monitor for a vip, similar as driver.
### command 'seqr'
Support to create sequencer, also same as driver.
### command 'trans'
- support rand fields
### command 'agent'
- same as driver
### command 'env'
- same as driver



# Use Cases
## global settings
```ruby
project :ResetGen
include 'uvm_macros.svh'
import 'uvm_pkg::*'
macro 'ResetGenWidth','128'
typedef 'bit[31:0] uint32_t'
typedef 'ResetStatusEnum','bit[1:0]','ACTIVE','INACTIVE','UNKNOW'
typedef 'ResetStatusEnum','int','ACTIVE','INACTIVE','UNKNOW'
typedef 'ResetStatusEnum','','ACTIVE','INACTIVE','UNKNOW'
```
*project*
setup the project name of this vip, so that no full name need to be specified while building like driver, monitor ...
format is `project <name>`
*includes*
extra include needed for this vip, except the builtin uvm.
format: `include 'file0'[,'file1',...]`
*import*
extra import needed for this vip, except the builtin uvm.
format: `import 'pkg::*'[,'pkg2::scope',...]'
*macro*
defining macros for this vip.
format: `macro 'macroname','macrovalue'`
*typedef*
typedef to setup types for this package.
format: `typedef 'type','extra bits','enumitem=value'[,...]`

## building driver
```ruby
driver :driver do
	# path 'slave'
	tparam 'REQ=ResetGenTrans'
	base 'uvm_driver#(REQ,RSP)'

	scalar 'int'...
	func 'name','r','a' do
		return <<-CODE.gsub(/\s+\./,'')
		.xxxx
		CODE
	end
end
```


## building monitor
monitor has same commands for driver.
```ruby
monitor :ext do
end
```


# Architecture

## Tool Shell
**rbcode** `toolshell`

## Global
### driver
global method to call Builder.createDriver
## Builder
### Builder::createDriver


## Driver
database of Driver, who will call `CodeGenerator` to publish a driver class file.

### commands for user source
Support commands for user:
- path, specify a path to generate current driver, if path not speicfied, will use './' by default;
- base, set base class of this driver
- params, support to store parameters:
	- tparam, typed parameter;
	- param, normal parameter;
- fields, declaring different fields, use a common `SVField` class.
	- scalar,
	- sarray,
	- ...
- methods, declaring and storing different methods, use a common `SVMethod` class.

### publishing apis
- finalize, rearrange codes.
- publish, use `codeGenerator` to generate driver codes.

## Monitor
Similar as 'Driver'.
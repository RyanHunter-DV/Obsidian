# Overview

## Feature List

- Building top.sv;
	- DUT instantiation and connection;
	- Interface declaration and configuration to env;
	- wavedump;
	- runtest;
	- imports and includes;
- building the TbEnv;
	- virtual seq/seqr pairs;
	- TbEnv file;
	- config file for TbEnv;
	- package file including all TbEnv stuff;
- building the UnitEnv;
	- UnitEnv file;
	- config file for UnitEnv;
	- package file including all UnitEnv stuff;
- support user commands through kind of source files to customize the target test bench;
	- clock, command to specify the clock interface in top.sv and ClockGen UVC in TbEnv;
	- reset, command to specify the reset interface in top.sv and ResetGen UVC in TbEnv;


---
# Detailed Features
## Global settings
### project setting
calling a 'project' command within the declaration of 'top' will set the global project name.
### VIP declaration
Before instantiating a vip, it must be declared first through the global 'vip' command by user source.
An VIP is declared by the global::vip command, by which the interface name, package name, and vip name will be specified, so that can be used while in instantiation.
*user source*
```ruby
vip :typename do
	...
end
```
By declaring a VIP in global, the exceeding top should also support that the certain vip being instantiated by calling with the vip's typename. For example:
```ruby
vip :Axi4Vip do
	...
end
top ... do
	Axi4Vip :instname,'axi4If','a0,b0'
end
```
*then what can be used in vip declaration?*
#### specify interface name
use 'interface' command to specify the vip's interface name.
```ruby
vip ... do
	interface :Axi4If
end
```
#### specify package name
use 'package' to specify the vip's package name, which will be imported at UnitEnv and Top.
```ruby
vip ... do
	package :packagename
end
```

## Top module building
### clock/reset declaration
A clock or reset can be declared at the top, by which can setup the ClockGen and ResetGen UVCs in EnvBuilder.
*user source example*
```ruby
top ... do
	clock 'tbClk','100mhz' # clockname,freq num,freq unit
	reset 'tbRstn','0','100ns'
end
```
### clock options supported
- clock name, the name of clock specified in top, it's only visible in user source view, and in SV view, it's one bit of the 'ClockGenIf.oClk'.
- frequence, input is a string with number and unit, the tool should translated it and setup in TbEnv's setup stage.

### reset options supported
- reset name, the name of reset specified in top, it's similar with clock name, is only available in Ruby view, and in SV view, it's one bit of 'ResetGenIf.oReset'.
- active value, specify the signal value when triggering the reset.
- initial time, used at the start of simulation, to active the reset for certain time.
### VIP instantiation
Since the Top requires VIP's interface and UnitEnv requires VIP's setup, the tool will combine those procedures by getting one user input in 'top' command.
*user source*
```ruby
top ... do
	RhAhb5Vip :instname,'mIf','port0,port1'
end
```
details about this method: [[#Top::vipinstname]].

### Interface instantiation
This used for specific VIP's interface, users are not required to enter any information since a VIP instantiation implicitly gives the tool interface information.

### DUT instantiation and connection
*SV code example*
```systemverilog
DUT DutInstance(
	.dutPort(mstIf.signal),
	...
);
```
*user source example*
```ruby
top ... do
	dut 'DUTModule','udut' do
		connect(
			'iClk'=>top.tbClk,
			'sigA'=>'mIf.sigA',
			'sigB'=>'mIf.sigB'
		)
	end
end
```


### builtin contents
- run test call
*SV code example*
```systemverilog
initial begin
	run_test();
end
```
### waveform dumping
Code to dump waveform, for version-v1, support basic waveform dumping only
#TBD 
### import and include information
- builtin uvm information
- interface used by this top should be included
- test package
- clock reset interfaces
```systemverilog
`include "uvm_macros.svh"
import uvm_pkg::*;
// other includes and imports based on user source.
```


## TbEnv Building
This tool can build a TbEnv according to user inputs from configurations of 'env' command and 'top' command can help build a TbEnv, files and contents to build are:
- the env file, named as `<project>TbEnv.svh`;
	- clock/reset uvc setup: declare and configuration;
	- UnitEnv setup: declare and configuration;
- the env config file, named as `<project>TbEnvConfig.svh`;
	- RHUDBG, setup controls for different debug features within this component;
- the package file, named as `<project>TbEnvPkg.sv`;
	- uvm include and import;
	- clock/reset uvc import;
	- local files: env, config, vseqr/vseq;
	- unit env import;
- virtual sequence and sequencer file, named as `<project>TbEnvVseq(r).svh`;
	- setup map in env, according to user entered pair information;
### setup a TbEnv
*user source example*
```ruby
env 'extname', :tb do
	...
end
```
using a 'env' command with 'tb' type and a block of configurations will startup the TbEnv, which will build all relative files to a specified root path.
### setup virtual sequencer pairs
*user source*
```ruby
env ..., :tb do
	vseqr 'flag'=>'vip0.seqr',''=>'' ...
	vseqr ''=>'' ...
end
```
### support to setup config table
A config table if the config object within an env, this tool supports users to setup the config table, even when no config table is specified by user, a config with empty fields will be generated as well, this rule also suits for building UnitEnv.
*user source*
```ruby
env ... do
	config do
		scalar, 'int','a'
		darray, 'int','da'
		aarray, 'int','string','aa'
	end
end
```

## UnitEnv Building
#TODO 

## Test Building
build through the TestBuilder tool. #TBD 

# Architecture

## major procedures
1. get options from command line, using options.rb as template, by `MainEntry`
2. reading source file, the entry is `top.rh`, which will load all other files
3. basic commands such as 'env','tbtop' etc, are located globally in main scope
4. setup and arrange all user sources through a call of `finalize`
5. building files and directories for each part through a `publish` call.

## publishing flow
To publish all codes, in the run of MainEntry will call Builder.publish directly, then all fields within the Builder, such as `@top`, `@tbEnv`, `@unitEnv` will be published one by one.

### Builder::publish
called by MainEntry.run, to publish top, tbEnv, unitEnv etc.
### Top::publish
Called by Builder.publish, a top is being stored as a field of Builder module, by calling this, which will:
1. filemacro;
2. sv module declaration;
3. includes and imports;
4. interface declaration for clock, reset and VIPs;
5. DUT instantiation and connection;
6. interface configure block;
7. waveform dumping;
8. runtest block;
#TODO 

## finalize flow
### Builder::finalize
rearrangement the database for publishing. It will call:
- top.finalize;
	- database preparation for run test, wavedump ... blocks;
- tbEnv.finalize;
	- database preparation for clock/reset UVC, according to db in 'Top';
- unitEnv.finalize;
	- database preparation for vip setup, according to vip db in 'Top';


## MainEntry
A typical MainEntry. In initialize, it will process options, while in run phase, it will call Builder to setup -> loadSource -> finalize -> publish 4 major steps.

## Builder
A ruby module used as generic builder that all other builders can access some of common contents.
### Builder::setup
The setup step, to setup The Builder module, initialize fields etc.
### Builder::loadSource
Loading user information from the given user sources, all global commands are defined here.


## Process 'vip' Command
example and description: [[#VIP declaration]].
- locates in 'lib/builder.rb';
- create a vip by calling Builder.declareVip;
- Top.define_method vipname;
	- find the declared vip object by Builder.find;
	- create new object of 'VipInst', store the 'Vip' object as base, and instname, interface inst and port connection information;
	- register the 'VipInst' object into 'Top' object;
- create a new object of 'Vip' that can eval the block coming with the vip command.
	- interface, store interface name in object fields;
	- package, store package name in object fields;
 
## Process 'top' Command
example: [[#Top module building]]
- locates in 'lib/builder.rb';
- create a new 'Top' object by Builder.createTop;
- instance eval the user block within 'Top' object;
- register 'Top' object into Builder.top;
- support commands:
	- project, store the specified project name, which will be used by other components;
	- clock, store the name, freq information; #TODO 
	- reset, store the reset information;
	- dut, To create a new DUT instance and store connect information, <link>;

## Process 'env' Command
example: [[#TbEnv Building]],[[#UnitEnv Building]]
- locates in 'lib/builder.rb';
- create a new 'Env' object by Builder.createEnv;
- instance eval user configurations by the 'Env' object;
- register 'Env' object to Builder.tbEnv or unitEnv, according to user configured type;
- support commands:
	- config, to setup user config table for this env;
	- vseqr, setup virtual seqr map;








#TODO 


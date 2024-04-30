


# Objects Definition

## Agent
This is the basic container of the ResetGen UVC, any time users instantiated a ResteGen, it acutally declares the agent component.
### Attributes
- config
- drv
- mon
- seqr
### apis
**build**
This is build phase, to build subcomponents, supports is_active mode.
1. if is_active:
	1. build driver, and pass config to driver
	2. build sequencer;
2. build monitor, and pass config to monitor

**connect**
1. seq_item_port connection when in active mode.
2. retrieve interface by uvm_config_db.

**createConfig(ifPath)**
create a config component and return to the env.
1. get the interface for config according to the ifPath.
	1. `uvm_config_db#(xxx)::get(null,ifPath,"ResetGenIf",config.vif)`
2. return config

**init(index,value,time)**
- setup the default_sequence for the sequencer's run_phase. (knowledge required: [[../../../../../Sources/UVM/default_sequence]]);
- call config.enable(index), only index called by init API will be treated as enabled reset;


## Config
The config table created by Agent's API, which will be called by user, and will be passed to sub components such as monitor, driver at build phase.
### Attribute
`bit enabled[int]`
- This array indicates the enabled reset indices. It's associative array that the int index indicates the reset index.
- The field will be configured while using calling ResetGen's init API.

*vif*
The virtual interface
### apis
**enable(index)**
1. set `enabled[index]` to 1;

## Trans
### Attribute
`int index`
- The index of the reset, indicates current trans represents which bit of the reset signal;
`realtime stime`
- The time this event happened, for driving, this time indicates how long the value will be driven;
`logic value`
- For driver usage, indicates the value to be driven;
- For monitor usage, indicates the value it being changed;
### apis
`# apiname : return`


## Driver
### Attribute
### apis
*mainProcess*
this is the main process started when run_phase starts, it'll forever loop for:
- check next sequence item.
	- start fork-join_none:
		- issue the reset immediately, and wait for time done.
		- wait posedge of refClk, then finish this thread.
- item done.

## Monitor
The monitor will collect the reset events of all signals and send out a reset trans containing:
- changed reset value.
- changed time.
- and the reset index.
This sample will be asynchronized, which means once the valued changed, then the trans will be collected.
### Attribute
### apis
`# run_phase(phase) : void`
1. search recursively of config.enabled;
2. if `enabled[index]` is 1, start a thread to monitor that signal;

## ResetGenSeq
The basic sequence to drive reset.

### Attribute
`logic value`
- the value to be driven
`realtime stime`
- the reset time;
`int index`
- reset index;
### APIs
`task reset(index,value,time,seqr)`
- trigger a reset started automatically.
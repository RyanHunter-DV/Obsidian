# Contents
- [[#setup]]
- [[#TLMs and connection]], #TBD 
- [[#setup configure table]], #TBD 
- 
# Source Code
**agent** `RhGpvAgent`
**tparam** `REQ=uvm_sequence_item,RSP=REQ`

## fields
```systemverilog
RhGpvDriver  drv;
RhGpvMonitor mon;
RhGpvConfig  config;
```
*relative links*
- [[libs/dv/gpv/src-rhGpvConfig.svh]]

## setup
**build**
```systemverilog
if (is_active==UVM_ACTIVE) begin
	drv = RhGpvDriver::type_id::create("drv",this);
	seqr= RhGpvSeqr::type_id::create("seqr",this);
	drv.config = config;
end
mon = RhGpvMonitor::type_id::create("mon",this);
mon.config = config;
```
## TLMs and connection
#TBD 

The connect phase shall get config of interface and connect the TLMs between driver and monitor etc.
**connect**
```systemverilog
if (!uvm_config_db#(RhGpvInterfaceControl)::get(null,"*",config.interfacePath,config.ifCtrl))
	`uvm_error("NIFC",$sformatf("no interface got from path(%s)",config.interfacePath))

// TLM connections
mon.resetP.connect(drv.resetI);

```
## setup configure table
The internal configure table is created by calling an API `createConfig` by upper level who has an instance of this component.
**func** `RhGpvConfig createConfig(string name)`
**proc**
```systemverilog
	config = RhGpvConfig::type_id::create(name);
	return config;
```

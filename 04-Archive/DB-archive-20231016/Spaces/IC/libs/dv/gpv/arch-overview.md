GPV (Generic Protocol VIP), is a uvm based agent that allows users to manually specific the relations between an abstraction level of packets to the bottom level of signals, so that users don't have to care too much of other redundent information while creating a specific agent. They only need to know how a transaction is mapped to the signal and timing of a driver, and signal/timing mapping to a transaction of a monitor.

# Sketch
## generic transaction
```systemverilog
class GpvTrans extends uvm_sequence_item;

	int cycles;
	uvm_bitstream_t vectors[];
	uvm_bitstream_t bitsen[];

endclass
```

```systemverilog
// in test level
function write_hreq();
	GpvSequence tr=new("tr");
	tr.vectors = new [2];
	tr.bitsen  = new [2];
	config.assemble(haddr,hsize,.hwrite(1),hwdata,tr);
	tr.start(vseqr);
endfunction
// in driver's run
req = get_next_item();
foreach (req.vectors[i]) begin
	config.drive(vectors[i],bitsen[i]);
	config.sync(1);
end
// in config
task drive(bit_stream_t vector);
	ifCtrl.drive(vector);
endtask
function assemble(haddr,hsize...);
	ifCtrl.addToVector("HADDR",tr.vectors[0],tr.bitsen[0]);
	ifCtrl.addToVector("HSIZE",tr.vectors[0],tr.bitsen[0]);
endfunction
// in interface controller
`define SIGMAP(name,pos) if (&mask[pos]) vif.name <= vector[pos];
task drive(bit_stream_t vector,bit_stream_t mask);
	`SIGMAP(HSIZE,1:0)
	`SIGMAP(HADDR,33:2)
	...
endtask
```

```systemverilog
// protocol map, translate transaction level information to drive object, which will be consumed by a driver
dobj.addToVector(id,value)
...
dobj.nextCycle();
dobj.addToVector(id,value)

// position setting, mapping the position with id

```

# Examples
[[cortexm4/ut/cm4_mpu_ppb_intf/arch-overview]]

# Features
## typical usage
To use the `RhGpv` package, users need provide a specific protocol object which derived from the `RhGpvProtocolBase`, and import the `RhGpv`, like:
```systemverilog
import RhGpv::*;
`include "UserSpecificTrans.svh"
`include "userSpecificProtocol.svh"
```
And then setup in its env, like:
```systemverilog
type parameter REQ=UserSpecificReqTrans;
...
RhGpv#(REQ,RSP) gpv0;
RhGpvConfig gpv0Config;
gpv0 = RhGpv#(REQ,RSP)::type_id::create(xxxx);
uvm_set_type_override_by_inst("this.gpv0.protocol",
	RhGpvProtocolBase::get_type(),
	UserSpecificProtocol::get_type()
);
gpv0Config = gpv0.createConfig("configName");
gpv0Config.interfacePath = "utTB.vif";
gpv0Config.otherConfig = "value";
```

## user specific protocol

## user specific transaction
another object users need provide is the high level transaction, which contains all basic fields users want to declare, like:
```systemverilog
rand bit[31:0] addr;
rand bit[7:0] rgn_select_oh_o;
```
# Architecture
- [[Spaces/IC/libs/dv/gpv/src-rhGpv.sv]], the package definition

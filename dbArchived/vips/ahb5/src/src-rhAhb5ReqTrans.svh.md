# Source Code
One transaction indicates to one htrans of an ahb burst, so that users can have maximum flexibility
to control their intends to send the request. The VIP will encapsulate a burst sequence that can
send typical burst by triggering multiple transactions.
**transaction** `RhAhb5ReqTrans`
**base** `RhAhb5TransBase`
**field**
```systemverilog
rand bit [2:0] burst;
rand bit [`RHAHB5_AW_MAX-1:0] addr;
rand bit [6:0] prot;
rand bit lock;
rand bit [2:0] size;
rand bit nonsec;
rand bit excl;
rand bit [3:0] master;
rand bit [1:0] trans;
rand bit [`RHAHB5_DW_MAX-1:0] wdata;
rand bit write;
rand int delay;

constraint delay_cst {
	if (trans==2'h2) {
		delay inside {[0:100]};
	} else {
		delay == 0; // for IDLE/SEQ/BUSY, delay is disabled by default
	}
};
```
**fieldutils**
```systemverilog
`uvm_field_int(burst,UVM_ALL_ON)
`uvm_field_int(addr,UVM_ALL_ON)
`uvm_field_int(prot,UVM_ALL_ON)
`uvm_field_int(lock,UVM_ALL_ON)
`uvm_field_int(size,UVM_ALL_ON)
`uvm_field_int(nonsec,UVM_ALL_ON)
`uvm_field_int(excl,UVM_ALL_ON)
`uvm_field_int(master,UVM_ALL_ON)
`uvm_field_int(write,UVM_ALL_ON)
`uvm_field_int(delay,UVM_ALL_ON)
`uvm_field_int(trans,UVM_ALL_ON)
`uvm_field_int(wdata,UVM_ALL_ON)
```

macros defined in [[vips/ahb5/src-rhAhb5Types.svh]].
The wdata is part of the request transaction, while the resp and data are in response transaction.
The base transaction defined in [[vips/ahb5/src-rhAhb5TransBase.svh]].

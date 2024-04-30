This sequence is a randomized single burst transaction
# Source Code
**sequence** `RhAhb5SingleBurstSeq`

## control size
**field**
```systemverilog
rand bit[2:0] __size;
```
**func** `void setSize(bit[2:0] s)`
**proc**
```systemverilog
__size.rand_mode(0);
__size = s;
```

## other random fields
**field**
```systemverilog
rand bit[3:0] __prot;
rand bit [`RHAHB5_AW_MAX-1:0] __addr;
rand bit __lock;
rand bit __nonsec;
rand bit __excl;
rand bit [3:0] __master;
rand bit [`RHAHB5_DW_MAX-1:0] __wdata;
rand bit __write;
rand int __delay;
// TODO
```

**fieldutils**
```systemverilog
`uvm_field_int(__size,UVM_ALL_ON)
```

## body
**vtask** `body()`
**proc**
```systemverilog
RhAhb5ReqTrans _req=new("req");
_req.randomize() with {
	trans == RHAHB5_NONSEQ;
	burst == RHAHB5_SINGLE;
	size  == __size  ;
	prot  == __prot  ;
	addr  == __addr  ;
	lock  == __lock  ;
	nonsec== __nonsec;
	excl  == __excl  ;
	master== __master;
	wdata == __wdata ;
	write == __write ;
// @RyanH	delay == __delay ;
};
`rhudbg("body",$sformatf("start item:\n%s",_req.sprint()))
start_item(_req);
`rhudbg("body",$sformatf("item(%0d) finished",_req.get_inst_id()))
finish_item(_req);
```

# Source Code
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
rand bit [1:0] trans[];
rand bit [`RHAHB5_DW_MAX-1:0] wdata[];
rand bit write;
rand int delay;

constraint delay_cst {delay inside {[0:100]};}
constraint transnum_cst {
	trans.size() == wdata.size();
	trans.size() inside {[1:4]};
}
```
macros defined in [[vips/ahb5/src-rhAhb5Types.svh]].
The wdata is part of the request transaction, while the resp and data are in response transaction.
The base transaction defined in [[vips/ahb5/src-rhAhb5TransBase.svh]].

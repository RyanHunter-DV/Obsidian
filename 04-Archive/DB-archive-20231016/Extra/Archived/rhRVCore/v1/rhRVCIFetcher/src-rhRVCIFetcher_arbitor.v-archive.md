

# Source Code
**module** `rhRVCIFetcher_arbitor #(PCW=32)`
**port** #TBD 
```verilog
intrPCR_vld_i
[PCW-1:0] intrPCR_pc_i
execPCR_vld_i
[PCW-1:0] execPCR_pc_i
grantedPCR_ack_i
grantedPCR_vld_o
[PCW-1:0] grantedPCR_pc_o
```

**block**
```verilog

cbufferWithClear#(PCW) ubuf0 (
	.clear_i(grantedPCR_ack_i),
	.en_i(intrPCR_vld_i),
	.d_i(intrPCR_pc_i),
	.en_o(intrPCR_vld_w),
	.d_o(intrPCR_pc_w)
)

// instances of arbitor
fixedCombArbitor3 uarb(
	.vld0_i(),
	.dat0_i(),
)
```
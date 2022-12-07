# Source Code
**module** `fixedCombArbitor3 #(WIDTH=32)`
**ports**
```verilog
vld0_i
[WIDTH-1:0] dat0_i
vld1_i
[WIDTH-1:0] dat1_i
vld2_i
[WIDTH-1:0] dat2_i
vld_o
[WIDTH-1:0] dat_o
```
**block**
```verilog
// generate data output
always @(*) begin
	if (vld0_i) dat_o = dat0_i;
	else if (vld1_i) dat_o = dat1_i;
	else if (vld2_i) dat_o = dat2_i;
	else dat_o = dat_o;
end
// generate vld out
always @(*) begin
	if (vld0_i|vld1_i|vld2_i) vld_o = 1'b1;
	else vld_o = 1'b0;
end
```

A combinational buffer.
# Source Code
**module** `cbufferWithClear #(WIDTH=32)`
**port**
```verilog
clear_i
en_i
[WIDTH-1:0] d_i
en_o
[WIDTH-1:0] d_o
```
**block**
```verilog
always @(*) begin
	if (en_i) begin
		en_o = 1'b1;
		d_o  = d_i;
	end else if (clear_i) begin
		en_o = 1'b0;
		d_o  = {WIDTH{1'b0}};
	end else begin
		en_o = en_o;
		d_o  = d_o;
	end
end
```
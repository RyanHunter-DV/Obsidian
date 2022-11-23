The metaAssembly is the flow to assemble meta design features into a verilog module. Currently supports verilog language only.
# Feature list
- [[#logical block assembly]], #TBD 
- [[#module instances]], #TBD 
- [[#signal auto declaration]], #TBD 

## logical block assembly
A specific bunch of logical operation can be defined as a design feature, and can be invoked while declaring a design.
The definition of a design feature can be like:
==strategy 1==
**defeature** `featureName00`
```verilog
always @(posedge <clk> or negedge <rstn>) begin
	if (!<rstn>) begin
		<signal0> <= 8'b000;
	end else begin
		case(<signal1>)
			3'b000: <signal0> <= 8 'h0000_0001;
		endcase
	end
end
```
Invoke of a defined design feature can be like:
**decall** `featureName00(clk_i,rstn,decoded,encode)`
==strategy 2==
```ruby
defeature 'featureName00' do
	raw <<-EOF
always @(posedge <clk> or negedge <rstn>) begin
	if (!<rstn>) begin
		<signal0> <= 8'b000;
	end else begin
		case(<signal1>)
			3'b000: <signal0> <= 8 'h0000_0001;
		endcase
	end
end
EOF
end
## feature called like:
featureName00(clk_i,rstn,decoded,encode)
```

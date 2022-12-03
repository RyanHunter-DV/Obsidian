The feature file will be treated as a ruby file, so it shall be called by `smdc-rb`, not this feature file compatible with that tool.
# bitAnd
feature of bit and operation, the operands from 2 to 10
**head**
```ruby
10.times do |idx|
	next if idx < 2;
	feature 'bitAnd'+idx.to_s, *opts do
		l="#{opts[0]} = #{opts[1]} & #{opts[2]}"
		sidx = 2
		while (sidx < idx) do
			l += " & #{opts[sidx]}"
			sidx+=1
		end
		verilog l
	end
end
```

# combine selection mux
It's a mux that select different value according to the condition.
**head**
```ruby
feature 'combineMux', *opts do
	c = opts[0] ## condition in string
	o = opts[1] ## the net to be selected
	t = opts[2] ## value when condition is true
	f = opts[3] ## value when condition is false
	verilog "o = #{c}?#{t} : #{f}"
end
```

# basicDff
The basic dff with en flag, when enabled, the q equals to d, else q keeps its original value.
**head**
```ruby
feature 'basicDff', *ops,**opts do
	ck  = ops[0];
	rst = ops[1];
	en  = ops[2];
	d   = ops[3];
	q   = ops[4];
	ckedge = 'posedge';
	rstedge= 'negedge';
	ckedge = opts[:ckedge] if opts.has_key?(:ckedge);
	rstedge= opts[:rstedge] if opts.has_key?(:rstedge);
	lines = [];
	
	lines << "always @(#{ckedge} #{ck} or #{rstedge} #{rst}) begin";
	if rstedge=='negedge'
		lines << "\tif (!#{rst})";
	else
		lines << "\tif (#{rst})";
	end
	lines << "\t\t#{q} <= 1'b0";
	lines << "else #{q} <= #{d}";
	lines << "end";
	verilog lines;
end
```
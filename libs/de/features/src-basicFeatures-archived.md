# bitAnd feature
supports from bitAnd2 ... bitAnd9
*format*: `lhs,op0,op1 ...`
bit and operation logic.
**code**
```ruby
10.times do |index|
	next if index < 2;
	feature "bitAnd#{index}".to_sym do |*s|
		l = "#{s[0]} = #{s[1]} & #{s[2]}"
		iindex=2
		while (iindex < index) do
			l+=" & #{s[iindex+1]}"
			iindex += 1
		end
		codes << l
	end
end
```

# compare logic
## compare two operands equality with a mask
*format*: `lhs,op0,op1,mask`
supports multiple bits comparing, with masks, the corresponding mask bit should be 1, or else that bit will be ignored.
the result `lhs` is 1 bit.
**code**
```ruby
feature :equalCompareWithMask do |*s|
	l = "#{s[0]} = ";
	l += "~(|((#{s[1]} ^ #{s[2]}) & #{s[3]}));";
	codes << l;
end
```

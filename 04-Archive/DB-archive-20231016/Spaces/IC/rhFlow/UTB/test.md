# top.rh
```ruby

# setup for vip such as interface
vip :RhAhb5Vip do
	interface :RhAhb5If
	package :RhAhb5Vip
end

top do
	project :TestProj

	clock :tbClk,100,:mhz
	reset :tbRstn,0,'100us'

	RhAhb5Vip :mst,:mstIf,"#{tbClk},#{tbRstn}"

	dut 'DUTModule','inst' do
		connect(
			'iClk' =>top.tbClk,
			'iRstn'=>top.tbRstn,
		)
	end
end

env :ext,:unit do
	config do
		field 'int',xxxx
		field ...
	end
	mst.config('configname'=>'override','config2'=>config.field2)
end
```


This file will be gnerated as `interface.rhda` which will be the interface declaration file for generating the rhRVCore RTL.
# Contents
- [[#IFetcherCR]]
- [[#IFetcherReq]]



## ChangePCReq
**interface**
```ruby
interface 'ChangePCReq' do |**opts|
	pcwidth = 32
	pcwidth = opts[:PCW] if opts.has_key?(:PCW)

	oports = {
		'vld' => 1,
		'PC'  => pcwidth
	}
	modport :transmit do
		oports.each_pair do |p,w|
			port p+'_o',w
		end
	end
	modport :receive do
		oports.each_pair do |p,w|
			port p+'_i',w
		end
	end
end
```
## IFetchReq
**interface**
```ruby
interface 'IFetchReq' do |**opts|
	pcwidth = 32
	pcwidth = opts[:PCW] if opts.has_key?(:PCW)

	oports = {
		'fetchReq' => 1,
		'fetchPC'  => pcwidth,
	}
	iports = {
		'fetchAck' => 1,
	}
	## define singleton method
	## transmit is for IFetcher, while receive is for the ICache
	modport :transmit do
		oports.each_pair do |p,w|
			port p+'_o',w
		end
		iports.each_pair do |p,w|
			port p+'_i',w
		end
	end
	modport :receive do
		oports.each_pair do |p,w|
			port p+'_i',w
		end
		iports.each_pair do |p,w|
			port p+'_o',w
		end
	end
end
```
## IFetcherCR
**interface**
```ruby
interface 'IFetcherCR' do |**opts|
	port 'clk_i',1
	port 'rstn_i',1
end
```


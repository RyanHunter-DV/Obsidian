# File Structure
- `./src`, the source dir
	- `./src/rtl`
	- `./src/verif`
- `./out`, the out dir, auto generated

*relative links*
- [[rhRVCore/src/rtl/icache/]]

# Features
- [[#support interrupts]]
- [[#fetch instructions]]

## support interrupts
This core can support maximum 16 global interrupts from outside of the core. Each interrupt is been treated as the pulse triggered interrupt, and has a priority from index 0~15.
For each interrupt comes, the hardware will automatically backup current registers and other information, preparing for processing the interrupt.

# Architecture

## rhRVC_IFetcher
The `rhRVC_IFetcher` module can send requests to `ICache` for requesting the instructions. 
### functionalities
- send fetch request after the component has reset finished.
- start fetching from the address: 0x100, which will be the first instruction
- #TBD 

### interface description
*the fetch request*
**interface**
```ruby
interface 'IFetcherReq' do |**opts|
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
*clock reset*
**interface**
```ruby
interface 'IFetcherCR' do |**opts|
	port 'clk_i',1
	port 'rstn_i',1
end
```


## rhRVC_IDecoder
To decode the RISC-V compliant instructions into micro commands that will be send to executor. One RISC-V instruction maybe divided into several micro commands.
### functionalities
- #TBD 
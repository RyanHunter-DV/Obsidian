
The `rhRVC_IFetcher` module can send requests to `ICache` for requesting the instructions. 
# functionalities
- send fetch request after the component has reset finished.
- start fetching from the address: 0x100, which will be the first instruction
- receive change PC request from other components
	- from executor that after a jump instructor
	- from interrupt handler that need to fetch an interrupt entry
- internal PC request generated cycle by cycle
- using arbitor to get next PC;
- #TBD 

### interface description
*the fetch request*
[[rhRVCore/v1/libs/src-interface.rhda#IFetcherReq]]
*clock reset*
[[rhRVCore/v1/libs/src-interface.rhda#IFetcherCR]]
*change PC request from executor*
[[rhRVCore/v1/libs/src-interface.rhda#ChangePCReq]]
*change PC request from interrupt handler*
[[rhRVCore/v1/libs/src-interface.rhda#ChangePCReq]]

# Source Code
This describes the component of `rhRVCIFetcher` which configures, and allocates all blocks, features and interfaces from declaration, and then to generate a verilog module by the description here.
**head**
```ruby
component 'RhRVCIFetcher' do
	type :vmod
	
end
```
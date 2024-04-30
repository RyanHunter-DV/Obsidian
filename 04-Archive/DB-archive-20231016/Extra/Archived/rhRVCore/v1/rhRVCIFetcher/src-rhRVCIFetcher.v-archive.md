
The `rhRVC_IFetcher` module can send requests to `ICache` for requesting the instructions. 
code locates in the rhRVCore project. This page is just a sketch.
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
requirements for setting up this component:
- [[#RhRVCIFetcher_arbitor]]
- 
**head**
```ruby
component 'RhRVCIFetcher' do
	type :vmod
	execPCR = ChangePCReq.receive 'execPCR'
	intrPCR = ChangePCReq.receive 'intrPCR'

	adhoc 'internalPCR_vld_w',1
	adhoc 'internalPCR_PC_w',32
	adhoc 'grantedPC_w',32
	adhoc 'grantedVld_w',1


	c_RhRVCIFetcher_arbitor(
		intrPCR.vld_i,
		execPCR.vld_i,
		internalPCR_vld_w,
		intrPCR.PC_i,
		execPCR.PC_i,
		internalPCR_PC_w,
		grantedPC_w,
		grantedVld_w
	);
end
```



## RhRVCIFetcher_arbitor
The arbitration block, getting change PC requests from executor, interrupter and internal, has following functionalities:
- the interrupter has the highest priority to change next PC, once this req is available, then other requests will be ignored then.
- the executor is the second priority.
- the internal request is the lowest priority.
**head**
```ruby
component 'RhRVCIFetcher_arbitor' do |*opts|
	type :block

	adhoc 'arbitorVld_w',3
	adhoc 'grantedVldOnehot_w',3
	a0 = 'arbitorVld_w'
	a1 = 'grantedVldOnehot_w'
	f_concat 3,opts[0],opts[1],opts[2],a0
	f_hightolowPArbitor 3,a0,a1

	f_combineMux3 opts[3],opts[4],opts[5],opts[6] do
		config "grantedPC_w==3'b001"
		config "grantedPC_w==3'b010"
	end

	f_bitor1 opts[7],a1
	
end
```


**head**
```ruby
component 'RhRVCIFetcher_arbitor' do |*args|
	type :block
	vlds = [args[0],args[1],args[2]]
	pcs  = [args[3],args[4],args[5]]
	grantedPC_w = args[6]
	grantedVld_w= args[7]

	adhoc 'arbitorVld_w',3
	adhoc 'grantedVldOnehot_w',3
	
	f__concat 3,vlds,arbitorVld_w
	f__hightolowPArbitor 3,arbitorVld_w,grantedVldOnehot_w
	f__combineMux3 grantedPC_w,"grantedPC_w==3'b001",pcs[0],"grantedPC_w==3'b010",pcs[1],pcs[2]
	f__bitor1 grantedVld_w,grantedVldOnehot_w
	
end
```
*feature libs*
- [[rhRVCore/v1/libs/src-feature.rhda]]
- [[Spaces/IC/libs/de/features-archive/src-logicFeatures#bitor]]
- [[Spaces/IC/libs/de/features-archive/src-logicFeatures#hightolowPArbitor]]
- [[Spaces/IC/libs/de/features-archive/src-logicFeatures#concat]]
- [[Spaces/IC/libs/de/features-archive/src-logicFeatures#combineMux]]

## strategy 2 for feature example
```ruby
component 'RhRVCIFetcher_arbitor' do
	input vld0,vld1,vld2
	input pc0,pc1,pc2
	output gvld,gpc

	f__concat vld0,vld1,vld2,tmp
	f__hightolowPArbitor tmp,tmp2
	tmp2.to f__bitor1 xxx
end
component 'RhRVCIFetcher' do

	execPCR = ChangePCReq.receive('execPCR')
	arbitor = c__RhRVCIFetcher_arbitor.alias

	execPCR.vld_i.to arbitor.inputa

end
```





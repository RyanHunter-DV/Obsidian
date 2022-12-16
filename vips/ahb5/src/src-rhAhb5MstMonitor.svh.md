

# Source Code
**monitor** `RhAhb5MstMonitor`
**base** `RhMonitorBase`
**field**
```systemverilog
RhAhb5MstConfig config;
```

## reset process
**vtask** `waitResetStateChanged(output RhResetState_enum s)`
**proc**
```systemverilog
logic sig;
config.getResetChanged(sig);
s = RhResetState_enum'(sig);
```
reference:
- [[vips/ahb5/src-rhAhb5MstConfig.svh#getResetChanged]]
## mainProcess
This is the main process task for monitoring the request/response information.
**vtask** `mainProcess()`
**proc**
```systemverilog

fork
	reqMonitor();
	rspMonitor();
join
```
## support monitoring requests
#TODO 
Monitor the request transaction, each htrans request will be monitored and sent through TLM separately.
There're two type of request transaction will be sent through different request port, one is `reqP`, another is `wreqP`, the `reqP` for all requests that collected at the end of the address phase, not caring about the data, while `wreqP` is specifically for write request, containing the write data.
**tlm-ap** `RhAhb5ReqTrans reqP`
**tlm-ap** `RhAhb5ReqTrans wreqP`
### reqWriteInfo
This is a queue to store the HWRITE vlaue of current request detected by `reqMonitor`, this bit is recorded because the response monitor need it. Every time a request is detected, the HWRITE bit should be push to this queue, no matter it's write or read
**field**
```
bit reqWriteInfo[$];
```
### main entry of request monitor
To monitor requests, the main entry task is `reqMonitor` which will be called in `mainProcess` and monitoring two type of requests with the major procedures:
- detect address phase of a request (hready high + htrans not idle);
- translate and send the address phase information through `reqP`;
- if it's a write request, then wait next cycle for wdata, and set data to the request that collected above;
- send current request to `wreqP`
**ltask** `reqMonitor()`
**proc** #TODO 
```systemverilog

forever begin
	RhAhb5ReqTrans req=new("req");
	__waitRequestValid();
	__collectAddressPhaseInfo(req);
	reqWriteInfo.push_back(req.write);
	reqP.write(req);
	if (req.write==1) begin
		__collectWriteData(req);
		wreqP.write(req);
	end else config.waitCycle();
end
```
### local task waitRequestValid
A task to wait the htrans not idle and hready is high, synchronizely with hclk
**ltask** `__waitRequestValid()`
**proc**
```systemverilog
bit done = 1'b0;
do begin
	if (config.getSignal("HTRANS") && config.getSignal("HREADY")) done = 1'b1;
	else config.waitCycle();
end while (!done);
```
reference:
- [[vips/ahb5/src-rhAhb5MstConfig.svh#waitCycle]]
- [[vips/ahb5/src-rhAhb5MstConfig.svh#getSignal]]
### local func collectAddressPhaseInfo
A function to get signal value from interface and recorded into req
**lfunc** `void __collectAddressPhaseInfo(ref RhAhb5ReqTrans r)`
**proc**
```systemverilog
r.trans = new[1]; // only 1 trans each for monitor
r.trans[0] = config.getSignal("HTRANS");
r.burst = config.getSignal("HBURST");
r.addr  = config.getSignal("HADDR");
r.size  = config.getSignal("HSIZE");
r.prot  = config.getSignal("HPROT");
r.master= config.getSignal("HMASTER");
r.lock  = config.getSignal("HLOCK");
r.write = config.getSignal("HWRITE");
```
reference:
- [[vips/ahb5/src-rhAhb5MstConfig.svh#getSignal]]
### local task collectWriteData
A task to wait one cycle and get current HWDATA from the interface
**ltask** `__collectWriteData(ref RhAhb5ReqTrans r)`
**proc**
```systemverilog
config.waitCycle();
r.wdata = new[1];
r.wdata[0] = config.getSignal("HWDATA");
```
reference:
- [[vips/ahb5/src-rhAhb5MstConfig.svh#getSignal]]
## support monitoring responses
#TODO 
monitor the response transaction, sending response for each htrans, and sends along with the request information. 
**tlm-ap** `RhAhb5RspTrans rspP`
## main entry of response monitor
The `rspMonitor` is the entry of the ahb5 response monitor, which will detect the hresp and hready signal, and will have following procedures:
- wait hready high
- if hresp has error, then record resp, pop reqInfo, and send back immediately
- if hresp has no error, then according to reqInf, set the write
- if is read, record the rdata to resp
- send resp
**ltask** `rspMonitor()`
**proc**
```systemverilog
forever begin
	RhAhb5RspTrans rsp=new("rsp");
	wait(reqWriteInfo.size()); // need wait last cycle has request.
	__waitReadyHigh();
	rsp.resp = config.getSignal("HRESP");
	rsp.iswrite = reqWriteInfo.pop_front();
	if (rsp.iswrite==0 && rsp.resp==0) rsp.rdata = config.getSignal("HRDATA");
	rspP.write(rsp);
end
```

reference:
- [[vips/ahb5/src-rhAhb5MstConfig.svh#getSignal]]

### local task waitReadyHigh
A task to wait HREADY high synchronizely by HCLK
**ltask** `__waitReadyHigh()`
**proc**
```systemverilog
bit done=1'b0;
while (!done) begin
	done = (config.getSignal("HREADY")[0]==1'b1)? 1'b1 : 1'b0;
end
```
reference:
- [[vips/ahb5/src-rhAhb5MstConfig.svh#getSignal]]

### build phase
**build**
```systemverilog
reqP = new("reqP",this);
rspP = new("rspP",this);
wreqP= new("wreqP",this);
```
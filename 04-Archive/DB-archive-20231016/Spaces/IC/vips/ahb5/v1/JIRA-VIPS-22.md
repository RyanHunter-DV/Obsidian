for write request:
reqCtrl is sent to driver for processing the HREADY signal.
reqData is sent to driver for recording write data
*RhAhb5ResponderBase*
```
# busyCycle : int
	returns a random int cycle for slave driver to drive HREADY low
# generateResponse(req) : rsp

```

*RhAhb5MemoryResponder*
```
class errorResponse
	rand error
	constraint error_cst {
		error dist {1 := 1, 99 := 0}
	}
# generateResponse(req) : rsp
	errorResponse.randomize()
	if errorResponse.error
		__generateErrorResponse__
	else
		__generateOkayResponse__
	if not error and is write
		recordWriteData(addr,data)
	if not error and is read
		get read data(addr,rsp.rdata)
- __generateErrorResponse__ : rsp
	hresp = 1
	
```

*RhAhb5SlvDriver*
```
- driveDelay()
	bc = responder.busyCycle()
	config.ifCtrl.HREADY(1'b0)
	config.ifCtrl.clock(bc);

+ mainProcess
	if receive reqCtrl
		- driveDelay
	rsp = responder.generateResponse(req)
	if rsp.hresp == error -> generate error response
	else generate okay response
```
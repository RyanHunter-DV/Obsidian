# Source Code
**class** `RhAhb5IfControl`
**param** `AW=32,DW=32`
**base** `RhAhb5IfControlBase`

## virtual interface
**field**
```systemverilog
virtual RhAhb5If#(AW,DW) vif;
```

## driveAddressPhase
**vtask** `driveAddressPhase(RhAhb5TransBeat b, bit waitReady)`
**proc**
```systemverilog
bit[AW-1:0] addr = __calculateCurrentAddress__(b);
vif.HADDR  <= addr;

vif.HTRANS <= b.trans;
if (b.trans==RHAHB5_NONSEQ) begin
	vif.HBURST <= b.burst;
	vif.HWRITE <= b.write;
	vif.HSIZE  <= b.size;
	vif.HPROT  <= b.prot;
	vif.HMASTLOCK <= b.lock;
	vif.HMASTER <= b.master;
	vif.HNONSEC <= b.nonsec;
	vif.HEXCL   <= b.excl;
end
if (waitReady) __waitHREADYSyncd__(1);
else @(posedge vif.HCLK);

```
reference:
- [[#waitHREADYSyncd]]
- [[#calculateCurrentAddress]]
## driveDataPhase
**vtask** `driveDataPhase(ref RhAhb5TransBeat b,output bit isError)`
**proc**
```systemverilog
vif.HWDATA <= b.data[DW-1:0];
fork
	__waitHREADYSyncd__(1);
	__responseError__(isError);
join_any
disable fork;
```
reference:
- [[#responseError]]
## waitDataPhase
**vtask** `waitDataPhase(ref RhAhb5TransBeat b,output bit isError)`
**proc**
```systemverilog
fork
	__waitHREADYSyncd__(1);
	__responseError__(isError);
join_any
disable fork;
```
## waitHREADYSyncd
A task to wait hread to be the target value synchronizely.
**ltask** `__waitHREADYSyncd__(bit val)`
**proc**
```systemverilog
do
	@(posedge vif.HCLK);
while (vif.HREADY !== val);
```
## responseError
detecting HRESP until it gets error, then return; or been killed by disable
**ltask** `__responseError__(output bit e)`
**proc**
```systemverilog
do begin
	@(posedge vif.HCLK);
	e = vif.HRESP[0];
end while (e==1'b0);
```

## getResetChanged
**vtask** `getResetChanged(output logic s)`
```systemverilog
@(vif.HRESETn);
s = vif.HRESETn;
```

## calculateCurrentAddress
A function to get current address according to the input trans beat information.
ref
- [[vip-rhAhb5Types.svh#RhAhb5TransBeat]]
- [[#decodeHSizeToByte]]
**lfunc** `bit[AW-1:0] __calculateCurrentAddress__(RhAhb5TransBeat b)`
**proc**
```systemverilog
bit[AW-1:0] addr;
rhahb5_hburst_enum burst = rhahb5_hburst_enum'(b.burst);
int byteSize = __decodeHSizeToByte__(b.size);
addr = b.addr[AW-1:0] + byteSize*b.index;
if (
	burst==RHAHB5_WRAP4 ||
	burst==RHAHB5_WRAP8 ||
	burst==RHAHB5_WRAP16
) begin
	case(byteSize)
		1: addr=addr;
		2: addr[0]   = 'h0;
		4: addr[1:0] = 'h0;
		8: addr[2:0] = 'h0;
		16:addr[3:0] = 'h0;
		32:addr[4:0] = 'h0;
		64:addr[5:0] = 'h0;
		128:addr[6:0]= 'h0;
	endcase
end
return addr;
```

## decodeHSizeToByte
#TBD 
A function to decode the hsize into the size of byte.
**lfunc** `int __decodeHSizeToByte__(bit[2:0] hsize)`
**proc**
```systemverilog
case (hsize)
	3'h0: return 1;
	3'h1: return 2;
	3'h2: return 4;
	3'h3: return 8;
	3'h4: return 16;
	3'h5: return 32;
	3'h6: return 64;
	3'h7: return 128;
endcase
```


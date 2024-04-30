# Source Code
**interface** `RhAhb5If(input logic HCLK,input logic HRESETN)`
**param** `AW=32,DW=32`

## master signal
**field**
```systemverilog
logic [AW-1:0] HADDR;
logic [1:0] HTRANS;
logic [2:0] HBURST;
logic [3:0] HMASTER;
logic [2:0] HSIZE;
logic [7:0] HPROT;
logic [DW-1:0] HWDATA;
logic HMASTLOCK;
logic HNONSEC;
logic HEXCL;
logic HWRITE;
logic HLOCK;
```

## slave signal
**field**
```systemverilog
logic [1:0] HRESP;
logic [DW-1:0] HRDATA;
logic HREADY;
logic HEXOKAY;
```

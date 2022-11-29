This page describes all features of ports, which can support many features as showed below.
# Features
- [[#declare a port]]
- [[#partial selection]]

## declare a port
To declare a port, just declared like:
```ruby
port 'portName_i',23
```
The suffix flag after the last underscore indicates the type of this port, which can be:
- `*_w`, is a flag of a wire signal
- `*_i`, is a flag of input signal
- `*_o` for output
- `*_io` for inout
- `*_r` for reg

## connect a port
A port can be connected by calling it's `connect` API. like:
```ruby
adhoc 'ppb_sel_oh_o',32
interface RhAhb5if.slave, :as => 'ppb0'
ppb_sel_oh_o[1].connect ppb0.HWRITE
ppb_sel_oh_o[3].connect ppb1.HWDATA[1]
```
#MARKER


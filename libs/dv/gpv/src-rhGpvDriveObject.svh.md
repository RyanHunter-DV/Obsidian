
# Source Code
**object** `RhGpvDriveObject`

## fields
**field**
```systemverilog
uvm_bitstream_t vectors[];
uvm_bitstream_t bitsens[];
local int __currentCycle;
```
## initialize
**new**
```systemverilog
// init one new vector/bitsen item.
vectors.push_back('h0);
bitsens.push_back('h0);
```
## nextCycle
used while translating from sequence item to drive object, means starting to add vectors to be driven on next cycle.
**func** `void nextCycle()`
```systemverilog
__currentCycle++;
// init the vectors and bitsens of this cycle
vectors.push_back('h0);
bitsens.push_back('h0);
```
## addToVector
API called by the protocol to add specific position of a vector, according to the bitsen and vector
**func** `void addToVector(uvm_bitstream_t val,RhGpvSigPos_t pos)`
**proc**
```systemverilog
int size = pos.e-pos.s+1;
vectors[__currentCycle][pos.e:pos.s] = val[size-1:0];
bitsens[__currentCycle][pos.e:pos.s] = {size{1'b1}};
```



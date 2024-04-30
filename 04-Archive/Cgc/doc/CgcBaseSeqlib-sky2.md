# FracPllBaseSeq

**object description**
Certain constraints and register fields of the fractional pll. This sequence extends from the base rtl sequence, storing for those configs are positioned in extended sequences such as [[#CpuPllBaseFreqSeq]].
**fields**
- `fbdiv`
- `postdiv1`, `postdiv2`
- `frac`
- `dsmen`
- ...

**constraints**
already listed in codes now.
**api actions**

# CpuPllBaseFreqSeq

## Object description
A base frequency generating sequence object for the cpu PLLs, it supports for: cpu0, cpu1, cpu2, cpu3 and cpu4.

## Fields
- `mux`, combined with base `frac` fields to generate the target frequency.
- `gater`, by default enable it in sequence constraint, can be overwritten by users.
- `string cpuname`, the name indicates which cpu this sequence will apply to, `cpu0` affects the `dsu_core0` and `dsu_core1`

## body
- uvm built-in task
- explicitly call super's body.
- add `mux` and `gater` set into `regs`.
# Design overview
// design feature category
Design concepts


# DV strategy

## Test reusability strategy

## Vip strategy
- clock/reset generators, use pre-built clock/reset generator vip, in github.
- axi slave vip, no self developed vip, use existing cadence vip.
- ace master vip,use cadence vip, need to investage how to use it.
- qlpi master vip,use pre-defined vip in github.use RhLpiVip
- apb master vip, #TBD

## Test strategy

# Env architecture

Typical UVM based environment architecture.

![image](https://res.craft.do/user/full/cacf2afa-0f20-25f2-c6b4-7560532e98b6/doc/083F1B08-47AA-407E-BFAE-7A0ED54993E5/9ca1425f-400f-43cc-928b-867793f8b37e)


## TbEnv, the top env that will integrate a UnitEnv
- vseqr, virtual sequencer
- uenv, the unit level env.
- regu, register utility, setting up different register modules.
## UnitEnv, is the tcu env that has vip, ref module components.

# DRVR
// detailed drvr table, locates in specific doc.
[[SmmuTcuDRVR-v1]]

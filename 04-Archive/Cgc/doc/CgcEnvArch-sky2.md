This is a formal documentation of CGC IP's verification environment architecture.
# Overview

# EnvArch
# TestArch

## Generic common pll sequence api
Since there're many plls in CGC block, much has similar configurations, so we need to figure out a generic api that can facilitate the coding as well as the flexibility of different plls. Base pll sequences are built for different usages, such as a baase clock generating sequence will only focus on clock generating features, so it will provide constraints and random fields for clock generating only.
Sequence feature list:
- fractional frequence generator sequence.
- 

# Sequences

## CgcFracFreqGenBaseSeq
Basic fractional frequence generating sequence. This sequence will automatically generate a fractional frequence for different pll instances which supports the frac mode, users shall set the pll name and freq before starting this sequence, and according to different pll name, some certain constraints will be enabled or disabled.
### user apis
- intMode(), this can force the target pll to generate freq by int mode, set dsmen to 0 and frac to 0, if not support, constrain will report error.
- pllName(), setting this to enable pll specific constraints, this is a must have api that shall be called by user.



## CgcIntFreqGenBaseSeq
This is for the pcie phy pll specifically.
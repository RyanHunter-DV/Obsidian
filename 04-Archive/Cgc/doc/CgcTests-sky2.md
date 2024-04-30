# CgcCpuLevel0SanityFreqTest
Test to generate a frequency with basic randomization that are pre-defined on the sequence.
**base** CgcBaseTest
**run**
- create sequence: CpuPllBaseFreqSeq.
	- set cpuname to cpu0/cpu1 for big core.
	- set frequency to 800MHz.
- create new sequence inst: CpuPllBaseFreqSeq.
	- set cpuname to cpu2/cpu3 for middle core
	- set freq to 600MHz.
- create a new sequence inst: CpuPllBaseFreqSeq.
	- set cpuname to cpu4 for little core.
	- set freq to 200MHz.

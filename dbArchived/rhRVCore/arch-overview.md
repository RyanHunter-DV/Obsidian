# File Structure
- `./src`, the source dir
	- `./src/rtl`
	- `./src/verif`
- `./out`, the out dir, auto generated

*relative links*
- [[rhRVCore/src/rtl/icache/]]

# Features
- [[#support interrupts]]
- [[#fetch instructions]]

## support interrupts
This core can support maximum 16 global interrupts from outside of the core. Each interrupt is been treated as the pulse triggered interrupt, and has a priority from index 0~15.
For each interrupt comes, the hardware will automatically backup current registers and other information, preparing for processing the interrupt.

# Architecture
## files for rhRVCIFetcher
- [[rhRVCore/v1/libs/src-interface.rhda]]
- [[rhRVCore/v1/rhRVCIFetcher/src-rhRVCIFetcher.v-archive]]


## rhRVC_IDecoder
To decode the RISC-V compliant instructions into micro commands that will be send to executor. One RISC-V instruction maybe divided into several micro commands.
### functionalities
- #TBD 
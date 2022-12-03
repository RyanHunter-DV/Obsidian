doc ref
[link template](https://github.com/RyanHunter-DV/rhRVCore/blob/main/doc/v1/readme)

---
the overall architecture diagram should be located:
[architecture diagram](https://github.com/RyanHunter-DV/rhRVCore/blob/main/doc/v1/rhRVCoreDiagram.jpeg)

# Feature list
- 16 global interrupt, pulse trigger
- 16KB I-Cache
- 64KB D-Cache
- support instruction map: RISCV-32IMA
- support ahb5 interface for control/data accessing out of the core
- instruction length 32-bit
- physical address width: 32-bit
- data width: 32-bit
- Cache line: 64byte
- single pipe line stage, one instruction fetch and issue every cycle

## interrupt processing




# SUB-IP level overview
## rhRVCoreIFetch
The instruction fetch sub-ip, send fetch request to ICache and gets the response instruction.
- one instruction can be fetched every clock cycle



# boot up sequence
#TBD 
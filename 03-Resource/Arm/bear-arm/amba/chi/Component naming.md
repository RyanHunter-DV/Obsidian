# Component naming
#reference/arm/amba/chi

#q how’s these nodes behave?
## RN
A request node, generates transactions, can have further detailed components:
- RN-F, Fully Coherent Request Node:
  - Include a hardware coherent cache, #q what’s this mean?
  - All transactions defined by protocol can be generated.
  - Support snoop transactions
- RN-D, IO request node with [[DVM]] support: #q what’s DVM?
  - generates subset of the full transactions defined by protocol, #q detailed transactions support?
  - receive DVM trans.
  - no hardware coherent cache.
- RN-I, IO request node:
  - no snoop trans.
  - generates a subset of full trans in protocol.
  - not receive DVM.
  - no hardware coherent cache.
## HN
Home Node, receives protocol transactions from RN, locates in interconnect behaves like a router maybe.
- HN-F, fully home node:
  - support full transaction protocol except the [[DVM]] operations.
  - support PoC (Point of Coherence) 
  #q what’s PoC details?
  > that manages coherency by snooping the required RN-Fs, consolidating the Snoop responses for a transaction, and sending a single response to the requesting Request Node.
  - support PoS (Point of Serialization)
  #q what’s PoS details?
  > that manages order between memory requests 
  - support directory or snoop filter, #q details?
- HN-I, 
- MN, Miscellaneous node:
## SN
Subordinate node, receive requests from HN, act as a slave devcie to complete request actions and retrun response.
SN-F
- Used for normal memory.
- Can process non-snoopable read, write and atomic
#q what’s snoopable read?
SN-I
#q features?definition?
- Used for peripheral or normal memory.
- can process trans same as SN-F.

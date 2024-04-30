# Cache state model
#reference/arm/amba
#reference/arm/coherent
#reference/arm/cache
## Valid and Invalid

## Unique and Shared
## Clean and Dirty
Clean means the cache line does not have responsibility to update to the main memory, whereas, if is dirty, then this cache line shall be updated to the main memory.
#q when or how to update to main memory?
## Full, Partial and Empty
Full is all bytes of this cache line valid, partial is one or more bytes, and can also include none or all bytes valid. Empty is no bytes valid.

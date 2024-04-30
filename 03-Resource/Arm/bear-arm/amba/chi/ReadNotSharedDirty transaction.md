# ReadNotSharedDirty transaction
#reference/arm/amba/chi
#reference/arm/amba/ace
> * Read request to a Snoopable address region to obtain a clean copy of a cache line. This can be used if the Requester is allocating the line to a cache that does not support dirty cache lines, such as an Instruction cache. Data must be provided to the Requester in either UC or SC states only. 

# Quality of Service mechanism
#reference/arm/amba/chi
## income & understanding
Combined with an interconnect and the end point device, to control the QoS priority value that can achive:
- maximum latency of a transaction.
- minimum bandwith of a data stream.
- best effort value of the bandwith or latency for a certain data path.
4-bit value to indicate the priority, with ascending values indicate a higher priority.
It’s initially assigned by the source transaction and can dynamically vary this value by accumulated latency or bandwith calculation.
So for the interconnect and receiver, the higher QoS value will let those devices to process the transaction prior than other actions, by which can help adjust the latency and bandwidth.
## how to describe & use it?

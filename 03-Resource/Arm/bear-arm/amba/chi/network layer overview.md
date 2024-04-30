# network layer overview
#reference/arm/amba/chi
- [ ] system address map, SAM
  it’s used to determine the output TgtID of the requests.
- [ ] node ID
  is used to declare a device that connected to a port with the interconnect. One port can have multiple nodeID, but one nodeID shall only used for single port.
## How to determine the TgtID?
*for requests*:
- if the RN or HN it connected both have the SAM ability, then the TgtID can be remapped if the RN request passed through the HN.
- [ ] what’s PCrdReturn? and how about this request’s TgtID?
- PrefetchTgt uses a different address to node ID since it will be sent to SN directly, other requests will sent to HN.
*for responses*:
- determined based on the received message.
  - must one of SrcID, HomeNID, ReturnNID or FwdID.
    - [ ] HomeNID?, ReturnNID?
different response message has different choose mechanism, this may better remembered.
- RetryAck response, TgtID is request’s SrcID nomatter it sent by HN or SN.
- PCrdGrant response,
  - - [ ] what’s this mean?
- more…
*for snoop request messages*:

## flow examples:
- simple flow
- flow with interconnect based SAM
- flow with interconnect base SAM and retry request.
- 

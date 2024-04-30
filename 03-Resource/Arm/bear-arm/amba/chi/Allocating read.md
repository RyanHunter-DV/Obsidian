# Allocating read
#reference/arm/amba/chi

Following trans support allocating read:

- [ ] what’s allocating read mean? or how it behaves? #q
allocating read means chi topology can have different alternatives to gets and operate the read transactions by different ways.
*combined response from HN*:
> The Home returns a combined response and read data, CompData, to the Requester. Typically, this option is used by the Home when data and response can be returned at the same time. An example is when the data is cached locally.

- [ ] how’s a typical read transaction operate? the behaviors of different channels #q

*separate data and response from HN*:
> The Home returns a separate response, RespSepData, and read data, DataSepResp, to the Requester. Typically, this option is used by the Home when a response can be returned quicker than the Home can provide the data.
- [ ] what’s RespSepData and DataSepResp? #q
  - RespSepData is a response message type: [[Response messages]]
  - DataSepResp maybe a data channel information indicates current data is separated with response info.
*combined response from SN*: #q need learn deeper.

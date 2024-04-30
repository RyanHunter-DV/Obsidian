# Channels overview
#reference/arm/amba/chi

## What’s channel?
#q
## Naming and definition for different channels
REQ channel, TXREQ for requester and RXREQ for subordinate
WDAT channel, TXDAT for requester, RXDAT for subordinate
- used for write data, atomic data snoop data, forward data etc.
- SN has no snoop data, forward data in RXDAT channel. #q why?
SRSP channel for requester, used for snoop response and completion acknowledge
CRSP channel, outbound from SN(TXRSP) and inbound to RN(RXRSP), for response.
RDAT, outbound from SN(TXDAT) and inbound to RN(RXDAT), for read data, atomic data.
SNP, inbound to RN(RXSNP), snoop request.
## Transaction fields?
[[Transaction fields]]

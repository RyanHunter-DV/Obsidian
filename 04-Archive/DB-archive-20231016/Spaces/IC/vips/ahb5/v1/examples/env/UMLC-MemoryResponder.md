**base**: `RhAhb5ResponderBase`
# Architecture
**generateResponse**
- if is write req, record the address and wdata to internal field queue in byte unit
- if is read, if address exists, then read from internal memory, else give back error response


# Attributes
**Attribute fields**

`+ Attribute type = defaultValue`
`- Attribute type = defaultValue`

# APIs
**API fields**

`+ generateResponse(req) : rsp`
A virtual function, which is empty in [[Spaces/IC/vips/ahb5/v1/UMLC-RhAhb5ResponderBase]]
In this class, it will generate response according to input req
**steps**:
- check req.type, if is write, then record the address and data

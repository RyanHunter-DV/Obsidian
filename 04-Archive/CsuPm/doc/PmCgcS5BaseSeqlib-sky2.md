
# PmCgcS5RtlSeq
**object description**
Instantiate the register utility object which set up at the env level, all extended sequences will store the register and fields setting values at the defined `regs` field, and this object provides a built-in action `post_body`, in which will start calling the [[RegisterUtility]] object' write functions to update the values in `regs`
**fields**
- `RegisterUtility regu`, The register utility block pre-set at env |
- `bit[31:0] regs[string][string]`, used by extended sequence to store the register name and fields that will be updated at post_body.
**api**
`task post_body`:
- built-in task called by body, to update registers by regu field
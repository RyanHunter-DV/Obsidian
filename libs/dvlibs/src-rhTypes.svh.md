# Source Code

## ResetEnum
**field**
```
typedef enum logic {
	RhResetUnknow   = 'bx,
	RhResetActive   = 'b1,
	RhResetInactive = 'b0
} RhResetState_enum;
```

## tlm imp declare
**field**
```systemverilog
`uvm_analysis_imp_decl(_reset)
```
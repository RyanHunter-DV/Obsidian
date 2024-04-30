# Source Code

## ResetEnum
**field**
```
typedef enum logic {
	RhResetUnknow   = 'bx,
	RhResetActive   = 'b0,
	RhResetInactive = 'b1
} RhResetState_enum;
```

## tlm imp declare
**field**
```systemverilog
`uvm_analysis_imp_decl(_reset)
```
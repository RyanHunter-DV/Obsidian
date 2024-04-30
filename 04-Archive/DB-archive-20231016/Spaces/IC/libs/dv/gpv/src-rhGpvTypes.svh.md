# Source Code
**field**
```systemverilog
typedef struct {
	int s;
	int e;
}RhGpvSigPos_t;

typedef enum {
	RHGPV_VALUE_RAISE,
	RHGPV_VALUE_DROP,
	RHGPV_VALUE_CHANGED
}RhGpvSigEvent_t;
typedef enum {
	RHGPV_COND_NONE,
	RHGPV_COND_OR,
	RHGPV_COND_AND
}RhGpvSigCond_t;
```
# Fields
**name +rw: string**
- name of the parameter, like: `'REQ'`
**value +rw: string**
- The value of the param, like: `'uvm_sequence_item'`
**type : bool**
- indicates current param is a type param or not, if is true, then is a type, combined with [[#istype]].
# APIs

## istype
1. return the value of the field: type.
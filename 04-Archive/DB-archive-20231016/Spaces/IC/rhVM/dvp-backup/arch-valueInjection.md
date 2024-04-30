This page depicts the architecture of a value injection VPI mechanism, the using cases, features and architecture about how to achive these features.
# links
- [[Spaces/IC/rhVM/dvp-backup/src-vpiVariable]]

# Using Examples
## set a value at a certain simtime
*simple example, using like:*
```cpp
#include <vpiVariable.h>


var = VpiVariable("utTB.a",DVP_DIRECTVAR);
var.inject(intValue,doubleScaledTime);
var.inject(bitValue,doubleScaledTime);
var2 = VpiVariable("utTB.ac",DVP_CLASSVAR);
var2.inject("name",strValue,doubleScaledTime);
// TODO, other types not considered yet.
```

*complicated circumstance, to access a variable within a dynamic class:*
```cpp
	vpiHandle tb = vpi_handle_by_name("utTB.ac",NULL);
    // vpiHandle tbI= vpi_iterate(,tb);
    vpiHandle var;
    // 621 - vpiClassObj
    vpiHandle p = vpi_handle(621,tb);
    // vpi_printf("\t-%s\n",vpi_get_str(vpiFullName,p));
    vpiHandle objI = vpi_iterate(vpiVariables,p);


    // vpi_printf("\t-%s\n",vpi_get_str(vpiFullName,cls));
    while (var=vpi_scan(objI)) {
        vpi_printf("\t-%s\n",vpi_get_str(vpiFullName,var));
    //     // vpiHandle P = vpi_handle(vpiParent,var);
    //     // vpi_printf("\t-%s\n",vpi_get_str(vpiFullName,P));


    s_vpi_value val;
    char n[128] = "newname";
    val.format=vpiStringVal;
    val.value.str = n;
    s_vpi_time time;
    vpi_printf("setting value now: %s\n",vpi_get_str(vpiFullName,var));
    vpi_put_value(var,&val,&time,vpiNoDelay);
    }
```
1. get class variable of `vpiHandle`
2. get `vpiClassObj` by `vpi_handle`
3. get object by `vpiClassObj`, and then getting iterator of `vpiVariables`, so that can be set.





# records
- frames in section 37.41 of LRM, which is used for automatic variables in a given task or function
	- extra investigation on vpi task call mechanism
- trace driver/loader feature of dvp
- thread debug feature
	- process the threads being called
	- how to get a thread and its current state?
- variables
	- variables can be got from the vpi_iterate, somehow, only within certain scope can get the variable, for example, a variable defined within a thread cannot be got from the vpiModule hierarchy
	- [[#get variable]]

*operating on vpiStmt:*
```cpp
d testProcess() {
    vpiHandle tb = vpi_handle_by_name("utTB",NULL);
    // vpiHandle tbI= vpi_iterate(,tb);
    vpiHandle var;
    // vpiHandle p = vpi_handle(vpiModule,tb);
    // vpi_printf("\t-%s\n",vpi_get_str(vpiFullName,p));
    vpiHandle objI = vpi_iterate(vpiProcess,tb);

    // vpi_printf("\t-%s\n",vpi_get_str(vpiFullName,cls));
    while (var=vpi_scan(objI)) {
        // 647 is vpiThread
        vpiHandle procI = vpi_handle(vpiStmt,var);
    }

```

# Examples
## get variable

```systemverilog
    ATestClass ac;
    initial begin
        ac=new("hello");
    end
```
```cpp
    vpiHandle tb = vpi_handle_by_name("utTB",NULL);
    vpiHandle tbI= vpi_iterate(vpiVariables,tb);
    vpiHandle sub;
    // vpi_printf("\t-%s\n",vpi_get_str(vpiFullName,cls));
    while (sub=vpi_scan(tbI)) {
        vpi_printf("\t-%s\n",vpi_get_str(vpiFullName,sub));
    }
```
can get the ac by above vpi


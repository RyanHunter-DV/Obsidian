# Component based log file
For uvm_component type, to build a file named as full name and change the "RHD" id action to UVM_LOG, so all reports with RhdInfo will be logged into the file.
For uvm_object type, will recorded in uvm_root log file.
# Configurable scope record
Especially in soc level simulation, dump all log files may cause a huge performance deduction, so users may require configurable scope of logging.
By using of `--rhdinfo-enable <scope>` or `--rhdinfo-disable <scope>` to enable or disable a certain scope of log.
The scope is implicitly wildcard enabled, which means the enable/disable switch will affect its sub components. For example: `--rhdinfo-disable "uvm_test_top.env.vip0"` will disable the logging of all components under vip0 instance.

---
# Strategies
## How info switch affects the sub components/objects?
Processed in RhdInfo object, check if UI has disable information whose path matched current report object, then skip it.
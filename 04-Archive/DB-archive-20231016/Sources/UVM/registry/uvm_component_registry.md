# Definition

# APIs


# Typical Usage
`comp = uvm_component::type_id::create(xxxx)`
- type_id is uvm_component_registry#(T,Tname)
- if context specified while calling create, then the context can be used as parent path


# Questions
## different between type_name() and get_type_name()
- type_name: a static api to get the registered Tname;
- get_type_name: a non-static api to get the registered Tname;


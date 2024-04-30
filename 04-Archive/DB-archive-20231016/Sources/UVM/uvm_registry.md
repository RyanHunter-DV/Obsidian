# Concept Definition
Object name, usages.

## uvm_object_wrapper
standalone virtual class

## uvm_component_registry

## uvm_registry_common
`#(type Tregistry,Tcreator,Tcreated)`
*provides common create API*
called by `uvm_registry_common#(a,b,c)::create(name,parent,context)`.
- call `Tcreator.create_by_type(Tregistry::get(),...)`

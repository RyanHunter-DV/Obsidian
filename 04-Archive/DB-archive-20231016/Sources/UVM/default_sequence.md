```systemverilog
  //| uvm_config_db #(uvm_object_wrapper)::set(null, "top.agent.myseqr.main_phase",
  //|                                          "default_sequence",
  //|                                          myseq_type::type_id::get());
  //
  // The uvm_resource_db can similarly be used.
```
to set the default_sequence to target sequencer's main_phase so that it can be automatically started at the main_phase, for run_phase, then set to run_phase.

# Mechanism
depends on factory and resource mechanism
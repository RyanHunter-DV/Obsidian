# run_test()
This task usually being called in the Top TB module to start the UVM running simulation.
1. `cs = uvm_coreservice_t::get()`, initializing the core service
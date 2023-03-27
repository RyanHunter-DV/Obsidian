DVB, is short of Design Verification Builder, which is used to build:
- Testbench, like top module, or other module, program based on SV.
- Env, the UVM based components, such as Env, VIP, Sequences etc.
- Stimulus, UVM based tests, sequences, and/or C++ based programming for CPU tests.

DVB is a hierarchical builder, which combines all standalone builders, for:
- Nested Testbench Builder.
- Unit Testbench Builder.
- VIP Builder.
- UVM Builder.

Each of above can be called alone by user according to the same formatted configurations, with different commands.

# UVM Builder
This is the basic builder that can build basic verification components such as a module, interface, driver etc.
#UVMB
- [[UVMB-Features]]
- 

# VIP Builder

#TBD 
# Unit Testbench Builder

#TBD 
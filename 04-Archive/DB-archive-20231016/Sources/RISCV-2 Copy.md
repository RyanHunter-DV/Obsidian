# Introduction
RISC-V is a new instruction set architecture that was originally designed to support computer architecture research and education, but which we now hope will also become a standard free and open architecture for industry implementation. Our goals in defining RISC-V include:
- A completely open ISA that is freely available to academia and industry.
- A real ISA that is suitable for direct native hardware implementation, not just simulation or binary translation.
- An ISA that avoid "over-architecturing" for particular microarchitecture style (e.g, micro-coded, in-order, decoupled, out-of-order) or implementation technology (e.g, full-custom, ASIC, FPGA), but which allows efficient implementation in any of these.
- An ISA separated into a small base integer ISA, usable by itself as a base for customized accelarators or for educational purpose, and optional standard extensions, to support general purpose software development.
- Support for revised 2008 IEEE-754 floating-point standard.
- An ISA that support extensive user-level ISA extensions and specialize variants.
- Both 32-bit and 64-bit address space variants for applications, system operation kernels, and hardware implementation.
...

We developed RISC-V to support our own needs in research and education, where our group is particulary interested in actual hardware implementations of research ideas (we have completed eleven different silicon fabrications of RISC-V since the first edition of this specification).

In our current research, we are especially insterested into move towards specialized and [[Sources/english/heterogenous|heterogenous]] accelerators.

## RISC-V ISA Overview
The RISC-V ISA is defined as base integer ISA, which must be present in any implementation, plus optional extensions to the base ISA. The base integer ISA is very similar to that of the early RISC processor except with no branch delay slots, and with support for optional variable-length instruction encoding.

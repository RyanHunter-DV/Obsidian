# Features of MDC
## declare a package
Users only need to declare a package with **package** keyword, and tool will automatically add:
- uvm includes, such as imports and includes of uvm basics
- package declaration
- user specified includes and imports by keywords: **imports** and **includes** after the key of **package**

## support user imports
use **import** mark to specify an import of other packages/fields, with a single line mark format, like:
**import** `APack::rhType`
**import** `APack::*`

## support user includes
use **include** to specify an include mark, use `path/name` as the file to be included.
## support identifiying the interface file
A file with a certain format will be treated as an interface file, and it'll be included outside of a package.
*format:*
`*If.sv` or `*Interface.sv`

# Examples
**package** `RhAhb5Vip`
**include** `testAfile.svh`
**include** `rhAhb5If.sv`
**import** `RhVipBase::*`

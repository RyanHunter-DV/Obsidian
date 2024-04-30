# Overview
[[../../../../Cards/DVB/UVMB-Features]]


# Features
## load user source
Users can provide an entry.rh file to build multiple separated UVM based files, each file can have its own path, like:
```ruby
# entry.rh
uvm_sequence :name do
	path ...
end
```


# Architecture

## ruby::Builder
This is the builder module of UVMB tool, to call step:
1. setup, tool initialization.
2. loadSource, load the user source, which is the entry of files to be generated.
3. finalize
4. publish

## ruby::Globals
| APIs                    | Comments                                   |
| ----------------------- | ------------------------------------------ |
| uvm_object(name,&block) | create ruby::UVMObject with name and block |

## ruby::UVMObject
[[class-UVMObject]]
## ruby::SVField
[[class-SVField]]
## ruby::SVMethod

| APIs                  | Comments                               |
| --------------------- | -------------------------------------- |
| initialize(type,args) | according to type, call different APIs |
| setupTask(args)       | setup database of SV task              |
| setupFunc(args)       | setup database of SV function          |

| Fields    | Comments                                                 |
| --------- | -------------------------------------------------------- |
| qualifier | qualifier for SV method                                  |
| name      | name of SV method                                        |
| mtype     | method type                                              |
| rtype     | return type, specific for SV functions                   |
| args      | argument string of SV method, 'input int a,output int b' |

## ruby::SVFile
Process file operations

| Fields               | Comments                                      |
| -------------------- | --------------------------------------------- |
| path +rw: string     | the specific path to build current file       |
| fop : FileOperator | object of FileOperator, created in initialize | 

| APIs                 | Comments                                                       |
| -------------------- | -------------------------------------------------------------- |
| initialize(filename) | store filename to ruby class field                             |
| buildfile(contents)  | building file through FileOperator object, with given contents |
| filemacro            | return codes of SV macro                                       |
| filemacroend         | return SV of end macro                                         |






# F-declareTLMs
Currently this tool only supports the analysis TLMs of following key actions:
- [[#declare a TLM in doc file]]
- [[#instantiate a new port/imp]]
- [[#add write function  for imp]]
- 
## declare a TLM in doc file
**tlm-ap** `transType portname`
**tlm-ae** `transType protname`
**tlm-ai** `suffix transType impname`
```systemverilog
// optional body for the write API
```

**tlm-ap is for analysis port, tlm-ae is for analysis export, while tlm-ai is for analysis imp.**

By detecting a **tlm-ap** or **tlm-imp** keyword, a new ruby class `SVTLM` will be created in `__processMark`.   Passing through the type of tlm first, then call setup to set other information such as class container name, port name etc. For imp type, 
Codes example:
```ruby
tlm = SVTLM.new('tlm-ai');
tlm.setup('transType','portName','className','suffix');
lines = [
	'// todo, code line 1',
	'// todo, code line 2'
];
tlm.addProcedures(lines);
```
The details of `SVTLM` refer to [[src-svTLM.rb]].

## instantiate a new port/imp
For component, this should located in build_phase, while for object, should located in object's new method. And the creation will be added to the container class automatically by the tool.
All automatic processes will be added to `smartAssembly` API in `svSupport.rb` code.
The `SVTLM` class of ruby provides a quick code line of API `createInSV`, so that in smart building, it can simply call like:
```ruby
addSVCode(tlm.createInSV());
```
The API [[src-svTLM.rb#createInSV]] provided by `SVTLM` and will return a string of SV code like:
`portname = new("portname",this);`
## add write function for imp
the body of the imp is optional, but mostly it's required by users to add the write body. Current tool supports this as a must-be option, so users must declare a new **tlm-imp** with a code block behind.
All automatic processes will be added to `smartAssembly` API in `svSupport.rb` code.
When in smart building, the prototype code of the write function can be given through tlm's `writePrototypeCode` directly, which will return the source code of the prototype in SV, such as:
`extern function void write_suffix(transType _tr);`
While the body will be returned through `writeBodyCode` by tlm.

# F-declareMethods
#TBD 
declaring methods feature contains:
- [[#declare builtin methods]]
- [[#declare manual methods]]

## declare manual methods
To declare a manual method, there're following marks can be used:
- **task** `name(input bit arg0,output bit arg2 ...)`
- **func** `returnType name(arg0,arg1...)`
- **ltask** `<sameFormatAsTask>`
- **lfunc** `<sameFormatAsFunc>`
- **vtask**, **vfunc**, **stask**, **sfunc**
*currently not support pure virtual methods*
Besides, this tool supports multiple line prototype, like:
**func**
```systemverilog
void funcName (
	testarg0,
	testarg1
)
```

Following those prototype declaration, a body of those methods are must. The body will be declared through **proc** mark, like:
**proc**
```systemverilog
// here can be empty, so there will be an empty method like:
/*
function a xxx;
endfunction
*/
```

To process above procedures, need a `SVMethod` ruby class, which can store key informaiton of method. The `SVMethod` can be used like:
```ruby
protos = ['void testFunc(','\targ0,','\targ1',')'];
m = SVMethod.new(protos,container);
body = ['line0','line1']
m.addBody(body);
```
Detailed information of `SVMethod` class, see [[src-svMethod.rb]]
## declare builtin methods
built-in methods, such as build_phase, connect_phase etc. We use special marks to identify those methods:
- **build**, for build_phase
- **connect**, for connect_phase
- **run** for run_phase.
- **new** for constructor.
those builtin methods won't be specified much detailed information as manual methods, users just need add extra codes if they want, or else the tool will aotumatically add a basic phases for these methods. For example:
**new**
```systemverilog
AClass a=new();
```
**build**
```systemverilog
drv = ADriver::type_id::create("drv");
```


# F-declareFields

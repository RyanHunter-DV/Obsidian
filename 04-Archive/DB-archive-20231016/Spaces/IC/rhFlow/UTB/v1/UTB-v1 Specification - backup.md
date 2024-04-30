# Overview






# Detailed Features

## Building top.sv


### VIP instantiation
*user source*
```ruby
top ... do
	vip :RhAhb5Vip,:mst,'mstIf(clock,rstn)' # vip,inst,interfaceInst
end
```


#TODO 

*partial selection signal*
The signal declared in an interface is of type `SVSignal`, by calling of which can return the sv signal directly.
- the signal declared within an interface will create a method same with the signal name, which will return the signal's code method, to return sv code.




### How to build top.sv?
Using 'TopBuilder', in publish, which will publish the dir and the top.sv according to given path.
1. TopBuilder.publish called;
2. TopBuilder.top.publish called, top is instance var created before;
3. top is object of 'TopModule', setup by user source;
4. top.publish will do:
	1. declareModule codes;
	2. import/includes for specific packages:
		1. uvm packages;
		2. VIPs
	3. VIP interfaces declaration and config setting
		1. clock/reset interface codes from [[#clock/reset declaration]];
		2. other VIP interfaces specified by interface command within 'TopModule';
	4. DUT instantiation and port connection codes;
	5. waveform dumping codes;
	6. 



## Building TbEnv

## Building UnitEnv





---
**Code Divider**








# SVInterface
Use to declare an interface, and will be used by who instantiate it to get the sv code for usages.
**file** `lib_v1/svInterface.rb`
**require**
```
svFile.rb
```
**class** `SVInterface < SVFile`


## SVInterface::code
the basic code api declared at the parent of `SVFile`, which will call different methods according to different usage:
- instanceCode, return code to instance an interface

**api** `instanceCode`
#TODO 
**api** `signalCode`
#TODO 


## global::interface
The global interface method, used to declare an interface, that can contain declare head, and signal declarations.
**def** `interface(n,&block)`
#TODO 


# TopBuilder
**file** `lib_v1/topBuilder.rb`
**require**
```
```
**module** `TopBuilder`
**field**
```
debug
root
top
```

## TopBuilder::setup
**api** `self.setup(r)`
```ruby
@root = r;
```

## TopBuilder::finalize
#TODO 

## TopBuilder::publish
publish the top.sv file.
**api** `publish`
```ruby
@top.publish(@root);
```
#TODO 

# TopModule
**file** `lib_v1/topModule.rb`
**require**
```
svModule.rb
```
**class** `TopModule < SVModule`
**field**
```
interfaces
duts
top
```

## TopModule::initialize
**api** `initialize(d)`
```ruby
super('top',d);
@interfaces=[];
@duts={};
@top=self;
```

## TopModule::interface
Support the interface command to be declared in this TopModule, and by calling the publish method in 'TopModule', the interface can be published.
**api** `interface(it,name,setn)`
- find a declared interface with the interface type from `Pool`;
- define a hash for interface instance, which has:
	- :instname => 'mIf'
	- :params=> 'a,b,c'
	- :ports=> 'a,b'
	- :handle=> SVInterface object
	- :setpath=> '...'
- store this into a ifs hash: 'top.#{instname}' => interface instance
- create a singleton method named as 'name' within this `Top` 
```ruby
intf = Pool.find(it,:interface);
raise RunException.new("no interface(#{it}) declared",3) if intf==nil;
setpath = "uvm_test_top.tbEnv.uEnv.#{setn}";
info = {};
info[:instname] = name;
# not support, info[:params] = '';
# not support, info[:ports]  = '';
info[:handle] = intf;
info[:setpath]= setpath;
@ifs["top.#{name}"] = info;
self.define_singleton_method name.to_sym do
	return intf;
end 
```


## TopModule::dut
**api** `dut(tn,as,&block)`
- create a new `SVDUT` object with tn
- give self to the SVDUT object
- evaluate the block within the created SVDUT
	- support connect, will store connection information
- register instname => object to Top's duts hash;
```ruby
tn=tn.to_s;as=as.to_s;
d = SVModule.new(tn,self);
d.instantiate(as,block);
self.duts[as] = d;
```


## TopModule::publish
To publish the file of top.sv by given root path
**api** `publish(r)`
```ruby
f = File.join(r,@filename);
cnts = [];
cnts.append(*filemacro);
cnts.append(*code(:declare));
# cnts.append(*code(:fields));
cnts.append(*code(:signals));
cnts.append(*code(:interfaces));
cnts.append(*code(:runtest));
cnts.append(*code(:wavedump));
cnts.append(*code(:instances));
cnts.append(*code(:declareend));
cnts.append(*filemacroend);
buildfile(cnts);
```


## Topmodule::runtestCode
#TODO 
return code of running test.
```ruby

```

# SVModule
This is a class for setting up and getting code of SV, *store this to codelib*
**file** `lib_v1/svModule.rb`
**require**
```
svSignal.rb
svField.rb
svFile.rb
```
**class** `SVModule < SVFile`
**field**
```
filename
modulename
debug
fields
instances
currentInst
```

## SVModule::initialize
**api** `initialize(n,d)`
```ruby
@modulename = n.capitalize;
@filename = "#{n}.sv";
@debug = d;
@fields= {};
@instances={};
@currentInst=nil;
```

## SVModule::code
**api** `code(u)`
to get SV code with different usage:
- :declare, return the code to declare a sv module
- :declareend,  return the code to finish the declare of a sv module
- return different code from api according to u->usage
example: `self.send(declareCode)`
#TODO 
```ruby
```

## SVModule::instantiate
- To create a new hash item to store the instance of this module;
- and then evaluate the block to add connections
**api** `instantiate(n,&block)`
```ruby
@instances[n] = {};
@currentInst = @instances[n];
self.instance_eval &block;
```
## SVModule::connect
Used to store the connections while this module being instantiated.
**api** `connect(**pairs)`
```ruby
pairs.each_pairs do |o,t|
	@currentInst[o] = t;
end
```

# SVSignal
#TODO 
For declaring the sv signals
**file** `lib_v1/svSignal.rb`
**require**
```
```
**class** `SVSignal`
**field**
```
name
container
debug
```

## SVSignal::initialize
**api** `initialize(n,c,d)`
```ruby
@container = c;
@name = n;
```

## SVSignal::code
**api** `code(e=-1,s=-1)`
```ruby
code = "#{@container}.#{@name}";
code += "[#{e}:#{s}]" if e!=-1 and s!=-1;
code += ";";
return code;
```



# SVField
**file** `lib_v1/svField.rb`
**class** `SVField`
**field**
```
debug
type
flag
```
## constructor
- args:
	- t->type of the field, symbol type, for uvm_field_*;
	- args, an array, that differentiated in different field type;
**api** `initialize(t,d,*args)`
```ruby
@type = t.to_sym;
@debug= d;
@flag = args.pop;
message = "register#{@type}".to_sym;
self.send(message,*args);
```
## register different type fields
**api** `registerint(ft,va,default='')`
```ruby
# ft->fieldtype, used to declare the sv field.
# va->varname,
# default->the default value, default is ''
@fieldtype = ft.to_s;
@name = va.to_s;
@default= default;
```
**api** `registerenum(ft,va,default='')`
```ruby
@fieldtype = ft;
@name = va.to_s;
@default= default;
```
**api** `registerreal(ft,va,default='')`
```ruby
@fieldtype=ft;
@name=va.to_s;
@default=default;
```
**api** `registerqueue(ft,va)`
```ruby
@fieldtype=ft;
@name="#{va}[$]";
@default='';
```
**api** `registersarray(ft,va,s)`
```ruby
# s->size, the size of array
@fieldtype=ft;
@name="#{va}[#{s}]"
@default='';
```
**api** `registerdarray(ft,va)`
```ruby
@fieldtype=ft;
@name="#{va}[]"
@default='';
```
**api** `registeraarray(ft,va,it)`
```ruby
# it->index type
@fieldtype=ft;
@name="#{va}[#{it}]"
@default=''
```
## getting svcode from field
- args:
	- u->usage, for field, there're
		- :instance, 
		- :ref, for reference, return the vaname
		- :utils, for uvm field utils
		- more are #TBD 
**api** `code(u)`
```ruby
message = "#{u}Code".to_sym;
return self.send(message);
```
**api** `instanceCode`
```ruby
l = "#{@fieldtype} #{@name};";
return l;
```
**api** `utilsCode`
```ruby
l = "`uvm_field_#{@type}(";
if @type==:enum
	l+="#{@fieldtype},";
end
l+="#{@name},#{@flag})";
return l;
```
**api** `refCode`
```ruby
return @name;
```


# Pool
It's a global module, for search/storing declared items.
**file** `lib_v1/pool.rb`
**module** `Pool`
**field**
```
pool;
```
**api** `self.register(o,t)`
to register a declared object with specified type
```ruby
@pool={} unless @pool.is_a?(Hash);
@pool[t.to_sym]=[] unless @pool.has_key?(t.to_sym);
@pool[t.to_sym] << o;
```
**api** `self.find(n,t)`
find by name according to given type.
```ruby
t = t.to_sym;
return nil unless @pool.has_key?(t);
@pool[t].each do |o|
	return o if (o.name == n.to_s);
end
return nil;
```
#TODO 

# Debugger
this is a common from codelib
**file** `lib_v1/debugger.rb`
**rbcode** `debugger`


# SVFile
used to operate file based behaviors
**file** `lib_v1/svFile.rb`
**class** `SVFile`
**field**
```
debug
rootpath
filename
```
## constructor
**api** `initialize(r,fn,d,ext='.svh')`
```ruby
@rootpath = r;
@filename = "#{fn}#{ext}";
@debug = d;
```
## returning code
**api** `code(u)`
```ruby
message = "#{u}Code".to_sym;
return self.send(message);
```
## building a file
**api** `buildfile(cnts)`
```ruby
@debug.print("buildfile: #{File.join(@rootpath,@filename)}");
fh = File.open(File.join(@rootpath,@filename),'w');
cnts.each do |line|
	fh.write("#{line}\n");
end
```
## file macros
**api** `filemacro`
```ruby
m = @filename.sub(/\./,'__');
cnts = [];
cnts << '`ifndef '+m;
cnts << '`define '+m;
return cnts;
```
**api** `filemacroend`
```ruby
return ["\n`endif"];
```
# SVMethod
a ruby class used to store sv methods information and placed with sv syntax code.  Major apis are:
- new, used to setup the user information for the prototype
- body, used to add lines of the method body
- code, with different input args, to return the method's prototype or body
	- body is sv code with function or task definition.

**file** `lib_v1/svmethod.rb`
**class** `SVMethod`
**field**
```
type
name
classname
rtn
args
qualifiers
procedures
debug
```

**api** `initialize(t,n,c,r,a,q='',d)`
```ruby
# t->type, :func, :task
# n->name of method
# c->classname
# r->return type for function only
# a->args
# q->qualifiers
@type = t.to_sym;
@name = n.to_s;
@classname=c.to_s;
@rtn  = r.to_s;
@args = a.to_s;
@qualifiers=q;
@procedures=[];
@debug = d;
```

**api** `body(line)`
```ruby
# line here can be multiple sv code lines with one string.
# or a single sv code line with one string.
@procedures << line;
```

**api** `code(u)`
```ruby
# u->usage, of :prototype, :body
message = "#{u}Code";
return self.send(message);
```
**api** `prototypeCode`
```ruby
h = 'extern';
h += " #{@qualifiers}" if @qualifiers;
if @type==:func
	h+=" function #{@rtn}";
else
	h+=" task";
end
h+=" #{name}(#{@args});";
return h;
```

**api** `bodyCode`
```ruby
cnts = [];
h = "";
if @type==:func
	h+="function #{@rtn}";
else
	h+="task";
end
h+="#{@classname}::#{@name}(#{@args});";
cnts << h;
@procedures.each do |b|
	bs = b.split("\n");
	bs.map!{|l| "\t"+l;};
	cnts.append(*bs);
end
if @type==:func
	cnts << "endfunction"
else
	cnts << "endtask"
end
return cnts;
```



[[../../../../Cards/DVB/uvmb-svclass]].

# Fields

**classname +rw: string**
- name of class.
**basename +rw: string**
- the base class name of this SV class, if not have parent, then basename is nil.
**params +rw: array**
- list of SVParams objects, for SV class's parameters,[[class-SVParam]].
**methods +rw: array**
- list of SVMethod objects, for SV class's methods, [[class-SVMethod]].
**fields : FieldContainer**
- container which contains [[class-SVField]] objects.
- [[class-FieldsContainer]].


# APIs
## initialize

## base
**prototype** `base(name)`
setup the basename of this class, it's a simple string, if has parameters then provide the name with param like: `'uvm_driver#(REQ,RSP)'`.

## tparam
**prototype** `tparam(*args)`
setup type parameters of this class, can set multiple args one time of call. like: `c.tparam('REQ=uvm_sequence_item','RSP=REQ')`.
1. filter the name and value part.
2. create new [[class-SVParam]], set name and value separately.
3. set the param's type to true.
4. register the created object to `@params`.
5. continue process 1-3 until all args are processed
## param
similar with [[#tparam]], but set the param's type to false.

## code
**prototype** `code(usage)`
API to return codes, it always returns an array nomatter how many lines the returned codes are.
1. according to usage, assemble a code message: `"#{usage}Codes".to_sym`.
2. return the result of calling the code message.
## task
**prototype** `task(name,arg,q='',&block)`
create a new task for this class.
1. create new [[class-SVMethod]], with name,arg,q args.
2. call block if it's given, arrange codes and then call new method's procedure API.
3. add this new method into `@methods`.
required:
- [[class-SVMethod#procedure]].
- [[class-SVMethod#initialize]].

## func
**prototype** `func(name,arg,r='void',q='',&block)`
similar with [[#task]], to create a function, using existing SVMethod class.

## field
This API can declare a user field for this class, it's a generic API that can declare various of fields. 
**prototype** `field(s)`
1. create new [[class-SVField]] object,`SVField.new(s)`.
2. register to fields in this class, call @fields.register.

## fields
1. return @fields.
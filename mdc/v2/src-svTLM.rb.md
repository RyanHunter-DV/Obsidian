A class supports all systemverilog TLM operations.
# initialize
The init setup when created. Requires mark in string, which will be treated as the tlm type as well, the tlm type is of type symbol.
```ruby
attr :tlmType;
attr :tlmName;
attr :tlmSuffix;
attr :transType;
attr :container;
attr :write; # the write method of type SVMethod
```
# setup
according to different port type, this method can process in different arguments, for tlm-ai type, it requires 4 arguments while others it requires 3 args only.
those arguments will be recorded as fields and will be used later in `createInSV`,  `writePrototypeCode` and `writeBodyCode`.

# addProcedures
input args are list of multiple code lines in SV. it's compatible even the input is empty list.
This method will first create `SVMethod`, then add types by calling the APIs provided by `SVMethod`.
For example:
```ruby
args = ['line0','line1'];
name = 'write'+tlmSuffix;
@write = SVMethod.new('void '+name+'('+@transType+' _tr)',@container,:func);
@write.addBody(args);
```
Details of `SVMethod` see [[src-svMethod.rb]].
# createInSV
called by smart builder, this API will return a string of raw SV code line of a TLM creation in SV.
return a SV code line such like:
`portname = new("portname",this);`
# writePrototypeCode
return prototype of write field in this class.
`return @write.prototype;`
# writeBodyCode
return body of write field in this class. `return @write.body;`

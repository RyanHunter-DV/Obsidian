#BACKUP
This document is a detailed development document, in which specified all features and the ==cb-rb== tool have, and by which, the tool will be generated, with tool of ==mdc-ruby==, version 2.

# Overview
## Feature List
- storing with a whole class, or a whole file that has specific purpose.
- operate on existing database, to add, remove or modify specific portion of the code.
- [[#commands and options based operation]];
## Use Cases
### insert a specific codelib
```example
**rbcode** `codeid`
```
### insert with a config file
```cmd
>> cb-rb insert classid -c configfile -f targetfile
```
### display code with pattern
```
>> cb-rb search "pattern"
```
### store a class into codelib
```
>> cb-rb store codeid -f sourcefile
```

# Detailed Feature Description

## commands and options based operation
command format: `cb-rb <command> [options]`
### store
Command used to store codes into database, Description should be specified by user.
*-f FILE,START,END*: specify the source file with start and end line, if is EOF, then the end line can omitted; So as the start line.
### search
To search the database with a pattern. Use case: [[#display code with pattern]]
*-l*: to list all matched codeid instead of showing the db information.
### insert
Insert the specified codelib into certain place.
*-f FILE,START*: specify the target file to be inserted, with a start line.

## storing with a whole class/module
A whole class or module is being specified to be stored to a class.
The tool provides a command 'store' to let users to store a class/module or even a file, by contents that capturing by '-f' option. Like:
```
>> cb-rb store -f <file,start,end>
```
## storing a whole file which has specific purpose
same as [[#storing with a whole class/module]]

## operate on existing database
This allows users to enhance their codes in database.
### add extra captured contents to existing db
using commands like:
```
>> cb-rb store -o <codeid,line> -f <file,start,end>
```
### update specific contents from db
Tool will open a new editor and let users to modify the db.

## selectable editor
let user setup an env var to choose which editor to be used by this tool.


## Architecture
This section will have a brief introduction of some key classes, and steps.
### Major Procedures
1. start cb-rb, with some global variables set: $toolhome
2. start the class ==MainEntry==, pass the ARGV to it, when initialized;
	1. `e = MainEntry.new(ARGV)`
3. in new function of ==MainEntry==, to process arguments, stored to @options;
4. start to call the run function of ==MainEntry==;
	1. `e.run()`
5. Then in run function of ==MainEntry==;
6. according to sub commands, to process the sub commands







---
**Code Divider**


# ToolShell
## Heads
**file** `cb-rb`
**require**
```
exceptions.rb
mainentry.rb
```
**def** `main()`
```ruby
begin
	e = MainEntry.new();
	e.run();
rescue RunException => e
	e.process();
end
```
**raw** `indent: 0`
```ruby
main();
exit 0;
```

# MainEntry
**file** `lib_v1/mainentry.rb`
**require**
```
options.rb
debugger.rb
```
*links*:
- [[#Options]]

**class** `MainEntry`
**field**
```
debug
options
mainCmd
fop
db
```

## MainEntry::initialize
- setup options by self option process;
- setup options through an OptionParser;
- collect all options into a field: `@option={}`;
**api** `initialize()`
#TODO
```ruby
## mainCmdProcess(argv);
o = Options.new();
@options= o.options;
setupDebugFeature;
@fop = FileOperator.new(@debug);
@db  = DataBase.new(@debug);
```

## setupDebugFeature
**api** `setupDebugFeature()`
```ruby
@debug = Debugger.new(@options[:debug]);
```



## MainEntry::run
**api** `run`
```ruby
message = "process#{@options[:mode].capitalize}".to_sym;
self.send(message);
```
## processStore
The main entry to process store command.
**api** `processStore`
1. capture source content from targetfile
	1. use fop.capture(fn,start,end)
2. call database's store
```ruby
cnts = @fop.capture();
@db.store(@options[:codeid],cnts);
```




# DataBase
The database is designed for translating the contents between a standard ruby code file and contents with some of key marks easy for store, search etc.
## File Heads
**file** `lib_v1/database.rb`
**require**
```
```
**class** `DataBase`
**field**
```
debug
```
## DataBase::initialize
**api** `initialize(d)`
- setup debug;
- 
```ruby
#TODO 
```

## DataBase::store
This api allows callers to store filtered code into the database, the incoming information is raw contents to be stored. The api will do:
1. search current db exists this codeid or not, if exists, then return with raising an exception.
2. collecting user descriptions by an interactive panel.
	1. [[#DataBase::getUserDesc]]
3. translated to database format.
	1. [[#DataBase::translateToDB]]
4. write into target db file, with specific codeid.
	1. [[#DataBase::writeDB]]
**api** `store(codeid,cnts)`
#TODO 
```ruby
raise RunException.new("codeid(#{codeid} already exists)") if hasCodeid?;
desc = getUserDesc();
info = translateToDB(cnts);
writeDB(codeid,info);
```

## getUserDesc
An internal def to get user description when they want to store a new codelib
**api** `getUserDesc()`
```ruby
mpf = "./.tmpf_cbrb_#{Process.pid}";
fh = File.open(tmpf,'w');
fh.write("please enter your codeblock description below:");
fh.close;
cmd = "vim #{tmpf}";
sig = system(cmd);
@debug.print("get vim return sig: #{sig}");
if sig!=true
	system("rm -rf #{tmpf}");
	raise RunException.new("description create failed",sig);
end
# read description
fh = File.open(tmpf,'r');
desc = fh.readlines();
fh.close;
system("rm -rf #{tmpf}");
desc.delete_at(0);
desc.each do |line|
	line.chomp!;
end
return desc;
```
## translateToDB
An internal def to translate ruby code into database format. This def returns an array of translated contents.
**api** `translateToDB(cnts)`
```ruby
# info format:
# info[:class],info[:desc],info[:apis]=[],info[:defs]=[]
# info[:requires]
# cm[:name]='', cm[:api] = []
api={};
isdef=false;
isclass=false;
cnts.each do |l|
	info[:requires] << getRequired(l) if requireDetected(l);


	if classDetected(l)
		info[:class] << getClassName(l);
		isclass=true;
	end
	isdef=true    if defDetected(l);
	isdef=false   if defendDetected(l);
	isclass=false if classendDetected(l);
end

return info;
```


#TODO 
## writeDB
An internal def to write database formatted contents into a target db file.
**api** `writeDB(id,cnts)`
#TODO 

# Options
#TODO 
**file** `lib_v1/options.rb`
**class** `Options`
**field**
```
options
```

## Options::initialize
**api** `initialize()`
```ruby
@options = {};
mainCmdProcess();
@options[:debug] = false;
@options[:mode] = :idle;
opt = OptionParser.new() do |o|
	o.on('-f','--file=FILE,START,END','specify the filename and position') do |v|
		processFileOption(v);
	end
	o.on('-l','--list','to list all matched codeids instead of contents') do |v|
		@options[:listed] = v;
	end
	o.on('-d','--debug','enable the debug feature') do |v|
		@options[:debug] = v;
	end
end.parse!
```

## processFileOption
This method to process the user option from '-f' and prepare the options for file, start, and end line.
**api** `processFileOption(src)`
```ruby
splitted = src.split(',');
len = splitted.length;
@options[:file] = splitted[0];
@options[:start]= 1; @options[:end]= -1;
@options[:start]=splitted[1] if len>=2;
@options[:end]=splitted[2] if len>=3;
return;
```


## mainCmdProcess
local method to process the options first
**api** `mainCmdProcess()`
```ruby
@mainCmd = ARGV.shift;
message = "preProcess#{@mainCmd.capitalize}".to_sym;
self.send(message);
return;
```
**api** `preProcessStore()`
```ruby
@options[:mode] = :store;
@options[:codeid] = ARGV.shift;
```
#TODO 
**api** `preProcessInsert(args)`
#TODO 
```ruby
@options[:mode] = :insert;
@options[:codeid] = ARGV.shift;
```
**api** `preProcessSearch(args)`
#TODO 
```ruby
@options[:mode] = :search;
@options[:pattern] = ARGV.shift;
```


# FileOperator
A file operator to interfere with files, such as:
- capture, capture the contents from a given file, between given lines;
- inject, inject specific contents to the specific file and line;
**file** `lib_v1/fileOperator.rb`
**require**
```
debugger.rb
```
**class** `FileOperator`
**field**
```
debug
```

## FileOperator::initialize
**api** `initialize(d)`
```ruby
@debug=d;
```


## FileOperator::capture
**api** `capture(fn,s=1,e=-1)`
- if e is -1, mean to capture until the EOF.
```ruby
fh = File.open(fn,'r');
cnts = fh.readlines();
e = cnts.length if e==-1;
captured=[];
cnts.each_with_index do |l,i|
	captured << l.chomp if i>=s and i<=e;
end
return captured;
```

#TODO 

## FileOperator::inject
#TODO 
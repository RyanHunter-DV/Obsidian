
# Source Code
**object** `RhuDebugPool`
**field**
```systemverilog

typedef string rhudbgStringQueue_t [$];
```
## the static creating and handle
**field**
```systemverilog
static RhuDebugPool sInst;
```
**sfunc** `RhuDebugPool getGlobalPool()`
**proc**
```systemverilog
if (sInst==null) sInst = new("globalPool");
return sInst;
```

## initialize
when first initialized, need get the values from command line, and setup key information.
#TODO 
**new**
```systemverilog
__setupUserOptions__;
```

*relative links*
- [[#setupUserOptions|__setupUserOptions__()]]
- 

## register
A function to register this class into the global debug pool, with its full instance path, with:
**field**
```systemverilog
uvm_object fullInstPaths[string];
```
**func** `void register(uvm_object obj,string objType)`
*procedures*
- if obj exists in instances, reflush the original one, by `obj.get_full_name()`
- if current path exists in `enabledIDs` as a key, then
	- create a file named as the full instance path
	- check if the obj `isaComponent`, pass file handle to its m_rh, else pass to uvm_root's m_rh
- return
**proc** #TBD 
```systemverilog

```
*relative links*
- [[#isaComponent]]
- 
## setupUserOptions
The function to process options in command line and recorded into local configuration.
Should support multiple settings like:
```
+RHUDBG="uvm_test_env.env,SPECIFICID;uvm_test_env.env.mst,SPECIFICID"
```
**field**
```systemverilog
string enabledIDs[string];
```
*procedures*
- get string from `$value$plusargs`
- check string, split it by `,` the former ones are instance path, while the latter ones are id
- check if id is `*`, then update the `enabledIDs[instPath]` to `*`
- if has multiple IDs, record to `enabledIDs[instPath]`
	- if already exists this instance path, then add like `{oldvalue,"|",newvalue}`;
	- if not, then directly assign to it;
- if single ID, behave similar as above steps
- return
**func** `void __setupUserOptions__()`
**proc** 
```systemverilog
string option;
string paths[$];
string ids[$];

// version 1, only support adding once through the user command line.
$value$plusargs("RHUDBG=%s",option);
__splitUserOption__(option,paths,ids);
foreach (paths[i]) enabledIDs[paths[i]] = ids[i];

```
*relative links*
- [[#splitUserOption|__splitUserOption__()]]

## splitUserOption
To separate multiple options by ';', and then split the path and id for each separated options
**lfunc** `void __splitUserOption__(string option,ref string paths[$],ref string ids[$])`
**proc**
```systemverilog
string options[$];
int len = option.len();int lastpos = 0;
if (option[len-1]!=";") option = {option,";"};

for (int idx=0;idx<option.len();idx++) begin
	if (option[idx]==";") begin
		options.push_back(option.substr(lastpos,idx-1));
		lastpos = idx+1;
	end
end
foreach (options[i]) begin
	string path, id;
	__splitOnePathIdOption__(options[i],path,id);
	paths.push_back(path);
	ids.push_back(id);
end
```


## splitOnePathIdOption
The local function to split path/id from user option like: `+RHUDBG=<path>,<id>`
**lfunc** `void __splitOnePathIdOption__(string option, ref string path, ref string id)`
**proc**
```systemverilog
int len = option.len();
for (int i=0;i<len;i++) begin
	if (option[i]==",") begin
		path = option.substr(0,i-1);
		id   = option.substr(i+1,len-1);
	end
end
return;
```

## processDisplayID
This function receives the id and object handle, to match the object's full path, and set actions of this id to log.

**func** `void processDisplayID(string id,uvm_object obj)`
*procedures*
- check if the same object and id been processed, then return, else continue;
- if `isaComponent`, call the obj's m_rh to set the action to `UVM_LOG` only.
**proc**
```systemverilog
if (__processedID__(id,obj.get_full_name())) return;
begin
	uvm_component comp=isaComponent(obj);
	uvm_report_handler rh;
	UVM_FILE file = __getLogger__({obj.get_full_name(),".log"});
	if (comp==null) begin
		uvm_coreservice_t cs=uvm_coreservice_t::get();
		uvm_root top = cs.get_root();
		rh=top.m_rh;
	end else rh=comp.m_rh;
	rh.set_severity_id_file(UVM_INFO,id,file);
	rh.set_severity_id_action(UVM_INFO,id,UVM_LOG);
	__addProcessedID__(id,obj.get_full_name());
end
return;
```

*relative links*
- [[#processedID|__processedID__()]]
- [[#addProcessedID|__addProcessedID__()]]
- [[#getLogger|__getLogger__()]]


## getLogger
This local function will check if a specified component inst's log file is opened or not.
If opened, then return the file handler, else open a new one and record it ot class member
**field**
```systemverilog
UVM_FILE openedFiles[string];
```
**lfunc** `UVM_FILE __getLogger__(string fn)`
**proc**
```systemverilog
UVM_FILE file;
if (openedFiles.exists(fn)) return openedFiles[fn];
file = $fopen(fn,"w");
openedFiles[fn] = file;
return file;
```


## addProcessedID
The local function to add specific id to the specified path.
**lfunc** `void __addProcessedID__(string id,string path)`
**proc**
```systemverilog
string newline = "";
if (processedIDs.exists(path)) newline = processedIDs[path];
newline = {newline,id,"|"};
processedIDs[path] = newline;
```

## processedID
return 1 if the id of the specific string path is being processed, else return 0

**field**
```systemverilog
string processedIDs[string];
```
**lfunc** `bit __processedID__(string id,string path)`
**proc**
```systemverilog
if (!processedIDs.exists(path)) return 1'b0;
begin
	string ids[$] = __splitidsToQueue__(processedIDs[path]);
	foreach (ids[i]) if (ids[i]==id) return 1'b1;
end
return 1'b0;
```
*relative links*
- [[#splitidsToQueue|__splitidsToQueue__()]]


## splitidsToQueue
local function to split a given string to id queue by the fixed separator: `|`. This function now can only split IDS like: "ID0|ID1|...|"
**lfunc** `rhudbgStringQueue_t __splitidsToQueue__(string s)`
**proc**
```systemverilog
int len = s.len();
string q[$];
int lastpos = 0;
for (int index=0;index<len;index++) begin
	if (s[index]=="|") begin
		q.push_back(s.substr(lastpos,index-1));
		lastpos = index+1;
	end
end
return q;
```

## isaComponent
local function to detect if the given obj is of type component, if is, return the casted component, else return null
**lfunc** `uvm_component isaComponent(uvm_object obj)`
**proc**
```systemverilog
uvm_component comp;
if ($cast(comp,obj)) return comp;
else return null;
```

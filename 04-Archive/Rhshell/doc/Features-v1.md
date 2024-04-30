This page lists all features Rhshell-v1 supports.
# Auto completion
For commands that been executed before, this tool supports automatically gives a hint for current command user is entering.
```
---------------------------------
welcome using Rhshell tool
xxxx
---------------------------------
>> ls -
>> 
```


# Special key detecting
- arrow key to quickly change cursor to the end of the command.
- ctrl+c to interrupt the current running program, or clear current prompt, which will not interrupt the rhshell self.



# pre-requisites
- [x] need check the stdin of ruby, if users entering keyboard will have a default std output or not? Or how to capture the keyboard input without print any words on current screen.
- [x] screen print with the cursor at a certain place of the printed string, not at the end, use linux format output feature: [[printFormats]]
- [x] how to detect special keys? use string.ord to convert a string to ascii code.
- [x] move cursor to right? use the [[printFormats]]
- [x] how to process the interrupt control? the getch can also get the interrupt char with ascii code equal to 3, just to process it as special keys.
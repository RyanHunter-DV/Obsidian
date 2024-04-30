# DataBase Format
## Example
**codeid** xxx
**description**
xxx
**requires** require
xxxx
**class/module** class or module name
**api** name # for class/module api
xxx, body
**def** name # global method
xxx, body

## codeid
The codeid is a unique id for the certain code lib. Which is named by user while storing the code.
## description
Manually added description information
## requries
This follows several lines of file names which will be placed as require key words in top of a ruby file.
The next word after this requires mark is the way to load the following files, by default it's require, but users can use their own method, such as 'rhload'.
PS: by this way, multiple requires marks can be placed within one codelib entry.
## class/module
Specifid that a class/module is placed here. For class inherited, the code can be: `**class** TestClass < ClassBase`
## api
specify an api within that class/module above.
#TODO 
## def
specify a method out of any class.
#TODO 
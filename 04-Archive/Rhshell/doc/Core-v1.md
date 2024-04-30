A module that directly called its `run` api by rhshell tool.

# init
- initialize all other required objects as a class member, and will be used at `run`
- create new threads for different panel, like:
```ruby
ui = UserPanel.new()
@uiThread = Thread.new{ui.start}
...
```
# run
- start panel's threads
```ruby
@uiThread.join
@exeThread.join
...
```


---
archive
- dead loop, until has exit: `while not readyToExit() ...`
- read user inputs, char by char: `ui.readNextChar()`
- if is enter char, call to start arranged command: `exe.run(arrangedCommand)`,
	- executor shall call commands like: `cmd > /dev/pts/tty...` so that the output of the command can be printed to screen immediately, not after the command done.
	- consider background executing, by entering `&` with the command, can create a new terminal to display the executing information.
- if is ctrl+c(signal: 3), call to kill running command: `exe.kill(currentRunningProcess)`, and re-render the prompt.
- if others, search from completion sources, choose the last history used command:
	- `cmp.search(cmd)`, cmd is an instance of [[UserPanel-v1|UserCommand]] object, which has key user command information.
	- `prompt.render(cmd.completion,cmd)`
- render output, use green color for user already entered command, supplements will be grey color;


# trigger(event: symbol, message: string)
- check event type
- call different actions define in core, for example:
```ruby
## if is ctrl-c
@exeThread.terminateCurrentJob()
@promptThread.refresh()
```

Supports events:
- ctrlc, signal interrupt event, received a ctrl+c user input
- exit, exit the program, receive a command 'exit' from execute panel.
- normal, the normal char input, treated as an input of the command prompt.
- arrowl, arrowr, arrowu, arrowd: the arrow events, arrow left, right, up and down.
- tab: the tab events, quick complete existing file/dirs.
- backspace: used for remove one char of the command.
Object that has user command information, such as current user input patter, matched completion command, and the position of the command cursor etc.
**base** [[CommonPanel-v1]]
# fields
`pattern`:
- public field which indicates what user has entered before he canceled or confirmed to execute this command.

# init

# completion
- return the matched command for completion.
# cursor
- return current cursor position from left most position as 0.

# execute
- called by start api.
- read next key from user.
- recognize the key.
	- if is CTRL_C key, send key to core: core.trigger(event: :ctrlc, message: ''), when the core receives this event, it will invoke different panel to respond this event, such like to stop executing command, and refresh the prompt to default.
	- other key events behaves similar: ENTER, NORMAL_CHAR, CTRL_R, BACKSPACE, TAB, ARROW_UP, ARROW_LEFT, ARROW_RIGHT, HOME, END …

# start
The super class's api called by the core object, and will actually call execute api.
reference: [[CommonPanel-v1#start(o Core Instance)]]

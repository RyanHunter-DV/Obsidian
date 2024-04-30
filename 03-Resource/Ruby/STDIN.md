# How to read user inputs without any feedback in screen?
- require the 'io/console',
- call `STDIN.noecho(&:gets)`, this will return a line
- or call `STDIN.getch()`, this will return a character, PS: this api is more fit for the Rhshell project.

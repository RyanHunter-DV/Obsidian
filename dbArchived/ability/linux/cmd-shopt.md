This is usefule when you want to call an alias as a command directly in a shell script, then adding alias like:
```bash
shopt -s expand_aliases
alias app="source ${APPHOME}/appShell.bash"
```
Then the `app` alias can be called directly by script file like:
```bash
#! /usr/bin/env bash
app load xcelium
```
if not using hte `shopt -s expand_aliases`, the `app` cannot called by another shell script.
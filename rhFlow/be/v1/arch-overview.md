# Features
- setup a project base, such as create directories, base flow files etc.
- loading tools, share components etc for every terminal that wanna run the project.

## setup project base
A tool ==be-build== will help build up the project base, before that, we need to decide what exactly need to build.
*building directories*
- `./<Root>`, the root dir specified by user option, to be created within current directory. Within `./<Root>/`, dirs will be created:
	- `src/`, storing source code files for this project, can split to sub dirs according to users, the base dirs are:
		- `design/`
		- `verify/`
		- 
	- `tools/`, local tools scripts that stores here
	- `__be__/`, local scripts, configurations that for bootenv. Such as the version of tools this project will use
	- `import/`, dynamically downloading other projects that will be used by this project
		- `*.impc`, the import config file, for different usage, a certain import config file can be loaded while downloading a tree.
			- details of this file refer to: [[#import config file format]]
			- #TODO 



## loading work environment
*loading separate tools*
A program that can load a specific tool/env. The tool named as `app`. Supports:
- load, to load a specific tool;
- unload, clear path of tool
using like:
```
app load tool/v2
app unload tool
```
details: [[#app]]

*loading project environment*
The `bootenv` command can load the tools for a specific project. It only works at the root dir of a compatible project.
by calling of this tool like:
```
be -v ENV_VIEW
```
will then load all tools, common libs and components before running projects. It will clear current shell environment and re source the login shell with project specific shell.
source code directly locates in `rhFlow/be` in GitHub.
# Architecture

## be-build
#TODO 
### import config file format
#TBD 

## bootenv
*programming strategies*
- while login, source the default shell in `rhFlow/be/setup.sh`, according to different shell, different files configured by login shell
	- now use `bash` here, and only supports bash now.
- after loading the `setup` shell, the command of `be` and the tool `app` is now recognized
- while calling `be -v ENV_VIEW`, it will:
	- clear/reload shell environment, two strategies
		- create a new terminal to start.
		- reload the shell environemnt by: `exec -c $SHELL ~/.($SHELL)rc`, #TBD 
	- start `gnome-terminator` with `source $behome/__be__.<sh/csh/zsh>`, preparing tools/envs that must for all projects
	- loading envs sets in `__be__/local/env.config`, this called by the `$behome/__be__.*` script
		- `env.config` is a xml like file, that can be load by a python tool in `$behome`, and gives specific commands to `$behome/__be__.*` and execute it.
		- detail format of `env.config` is in [[#format of env config file]]
	- done with a newly create terminal, then proceeds to do project commands.
### format of env config file
it's a xml like file, has features like:
**env variable setting**
```xml
<env>
	<var>varname</var>
	<val>value</val>
	<var>varname2</var>
	<val>value2</val>
	...
</env>
```
**examples**
```xml
<env>
	<var>pcieAnchor</var>
	<val>$STEM/import/pcie</val>
	<var>verifyRoot</var>
	<val>$PROJROOT/src/verify</val>
	<var>envPath</var>
	<val>$verifyRoot/env</val>
	<var>userOptionEn</var>
	<val>1</val>
</env>
```
**tools or sharecomponent loading**
```xml
<app>
	<cmd>load</cmd>
	<name>xcelium</name>
	<ver>22.01.13-SP</ver>
</app>
<app>
	<cmd>load</cmd>
	<name>RhAhb5Vip</name>
	<ver>v1</ver>
</app>
```

## app
The app tool is implicitly loaded while in the source of the `setup.*` program while logging in.
According to different shell type, the different `__app__.*` will be applied to the alias command.
*major procedures of the app*
- `__app__.*`, the entry of this tool according to different shell type
- pre-process the command by an internal script: `__optionProcess__.rb`
	- for command: `app load xcelium`, will give out an implicity version: current for the app main program: `app load xcelium current`
	- for others like: `app load xcelium/22.02.2`, will give out 4 separated params: `app load xcelium 22.02.2`
- finding `app.config` file within the specific path: `/tools/xcelium/current`
	- if not find the file, then return imm
- if find the file, then call a local script to process the xml like formatted `app.config` file, call `__appConfigProcess__.rb <file>`
	- current supported format of `app.config` are: [[#app config format]]
- the app config processor will return different commands by screen print, and the main app will eval it to setup environments
*file structures*
it's too simple so just defined in while in code implementation.
### app config format
```xml
<env>
	<var>envVar</var>
	<val>value</val>
</env>
```


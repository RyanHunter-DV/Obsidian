This chapter depicts an overall architecture of MDC tool, which containing:
- [[#File Structure]]
- [[#Generic Procedures]]
- 

# File Structure

-   ./mdc , executor
-   ./lib/, lib dir, stores all included files
-   ./test/ dir,test program.


# Generic Procedures

- [[#main entry mechanism]]
- read source md file, (skipped since code done)
- smart automatic building
- generate target files

## main entry mechanism
MainEntry class is for starting the generic procedures, calling in mdc executor is like:
```ruby
rhload 'lib/mainentry';

e = MainEntry.new();
$SIG = e.run();
exit $SIG
```

## smart automatic building
#TBD 

after capturing all key information, this tool will start building the target file, according to different target type (currently supports C++ and SV only).  
building steps are:
-   file architecture building, things like file name, file macros, file description etc.
-   for building classes, use prototype or procedures, which will build:
    -   class head, declaration of class
    -   class body
-   for other blocks, simply use one of above types to build

## generate target files
#TBD 

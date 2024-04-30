A component object will be created through a global component API, and will be created and registered in a `ComponentPool` module, but only components that instantiated by a `Config` will be built through buildflow.
included in [[MainEntry]]


# process body definition
==support component commands==
- [[#required]], need other components, #TBD 
- [[#compopt]], setup compile commands for this component, #TBD 
- [[#elabopt]], setup elaboration commands for this component, #TBD 
- [[#simopt]], setup simulation commands, #TBD 
- [[#fileset]], source files that will be listed in a filelist, #TBD 
- [[#include]], files that will not be listed in a filelist, but may be included by a source file, #TBD 
*process required components*
all required components called by `required` will be stored into a specific hash, while in component finalization, the required will be searched first within all the contexts, if not found, then report error and exit, else get all required components object and finalize it.



# commands
## required
A component can be required by another one, by the `required` command. All required components are listed and will be evaluated before the loading component.

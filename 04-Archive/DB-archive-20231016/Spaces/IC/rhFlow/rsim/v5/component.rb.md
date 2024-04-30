- global component command used by nodes and root.
`component :name do ... end`
- Component class shall support:
	- fileset command, files to be read by generator.
	- generator command, call generator to build target.
	- channel command, basic interfaces definition used for interconnection.
	- busInterface, define the ports of current component.
	- component name shall be a vlnv type: 'vendor/library/name/version'.
	- parameter, the parameter definition of current component.
- use an example from smmu or star module.
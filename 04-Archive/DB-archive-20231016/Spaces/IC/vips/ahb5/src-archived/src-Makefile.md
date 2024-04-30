# Source Code
To generate the makefile script, here is the most simplify version
**field**
```make
conf := masterOnly
test := masterBaseTest
xbuild: mdbuild
	simf -e 'buildflow(:${conf}).run'

mdbuild:
	mdcs ~/GitHub/Obsidian/vips/ahb5/src/ ./src

sim:
	simf -e 'runtest(:${test}).run'

clean:
	rm -rf out/
```

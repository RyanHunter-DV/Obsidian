# initialize
## argument required
two args are required to initialize the `SVPackage` object:
- `name=''`, use to specify that package name
- `body=[]`, all collected **import** and **include** of that package, the manually specified imports and includes are ordering required, so input of `body` should has the same order of user written in the MD doc.
Arg of the `body` will be like:
```ruby
body = [
	'import aaaa\nbbbb',
	'include aaaa\nbbbb',
]
```
And it'll be translated database in `SVPackage` with format like:
```ruby

i0 = {:type => 'import', :value =>'xxx'}
i1 = {:type => 'include',:value =>'xx/ff.sv'}
body = [i0,i1]

```
## procedures

- add built-in includes and imports, such as uvm_pkg
- detect interface include and split it to a special place
- rearrange the order of built-in includes/imports and remaining user includes/imports
- All information should be arranged in this initialization method.

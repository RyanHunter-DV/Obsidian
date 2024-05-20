```bash
v=xxx # declare variable, by default is global
local v2=xxx # local variable
echo $v # use variable
v3=xxx
readonly v3 # set as readonly

```

# array
```bash
declare -A site=(["google"]="www.google.com" ["runoob"]="www.runoob.com" ["taobao"]="www.taobao.com") # associative array
myArray=(1 2 3) # declare array
declare -A associative_array # associative array
associative_array["name"]="John" # no space between = is required
associative_array["age"]=30
echo ${associative_array["name"]}
echo ${associative_array[@]}
```
- [x] how to echo a full array? use `@` symbol as the array index.
## display keys of associative array
```bash
declare -A site
site["google"]="www.google.com"
site["runoob"]="www.runoob.com"
site["taobao"]="www.taobao.com"

echo "数组的键为: ${!site[*]}"
echo "数组的键为: ${!site[@]}" # same usage as above
echo "length: ${#site[@]}" # display length of array.
```
# special variables
![[Pasted image 20240520104059.png]]
![[Pasted image 20240520105115.png]]

# string
*display string length*
```bash
s="hello"
echo ${#s}
# get sub string
echo ${s:1:2} # position can be given by a variable
```
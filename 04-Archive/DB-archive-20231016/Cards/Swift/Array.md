# Declare a new array
```swift
// declare a default static array
// arr = [<type>] (repeating: <repeatvalue>, count: <countnumber>)
var arr = [Int32] (repeating: 0, count: 10)

// no repeating static array
var arr: [Int32] = [10,20,30]

// dynamic array declare
// arr = [<type>]()
var arr = [Int32]() 
var arr: [Int32] = []


```

# Access the array
```swift
print(arr[2]);
```
[[String#Formatted print]], print array element with a string.
## array iteation
```swift
// use for item in array ...
for item in arrobj {
	print (item)
}
```

# Built-in methods for a declared array
## append
arrayobj.append(element), append a new element to the declared arrayobj.
## plus operator
this operator can be used to merge two same typed arraies.
## count
arrayobj.count(), return the number of current array
## isEmpty
arrayobj.isEmpty() returns true if array is empty, else return false

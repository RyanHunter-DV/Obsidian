# Define a function
```swift
func fname(arg0: String, arg1: Int) -> UInt32 {
	.....
}

func fname() -> UInt32 {
	...
}
func fname() -> (min: Int32,max: Int32) ...
```

## define a func that can pass a pointer of argument
```swift
// declare with inout to specify the a is a pointer.
func fname5(a: inout Int32) {
	a=4;
}

var aa : Int32 = 3;
// use & to pass the aa variable's address, like a pointer.
fname5(a: &aa);

print(aa);
```

## A function entry position can be specified to a var or an argument of another function
```swift
func sum(a: Int, b: Int) -> Int {
    return a + b
}
var addition: (Int, Int) -> Int = sum
func nf(add: (Int,Int)->Int) -> Int {...}

func fname5(a: inout Int32) {
a=4;
}

var aa : Int32 = 3;
fname5(a: &aa);
print(aa);
// declare a function prototype with no return type to a variable.
var fa: (inout Int32)->() = fname5
```

## Nested function declaration
```swift
func calcDecrement(forDecrement total: Int) -> () -> Int {
   var overallDecrement = 0
   func decrementer() -> Int {
      overallDecrement -= total
      return overallDecrement
   }
   return decrementer
}
let decrem = calcDecrement(forDecrement: 30)
```


# Class function
to declare a function with class qualifier, so that it's a class function, can be called directly by the class type, and it can also be used to declare a virtual function.

# mutating func
- Useful for a struct or enum type, whose property cannot be changed by default.
```
Swift 语言中结构体和枚举是值类型。一般情况下，值类型的属性不能在它的实例方法中被修改。

但是，如果你确实需要在某个具体的方法中修改结构体或者枚举的属性，你可以选择变异(mutating)这个方法，然后方法就可以从方法内部改变它的属性；并且它做的任何改变在方法结束时还会保留在原始结构中。

方法还可以给它隐含的self属性赋值一个全新的实例，这个新实例在方法结束后将替换原来的实例。

import Cocoa

struct area {
    var length = 1
    var breadth = 1
    
    func area() -> Int {
        return length * breadth
    }
    
    mutating func scaleBy(res: Int) {
        length *= res
        breadth *= res
        
        print(length)
        print(breadth)
    }
}

var val = area(length: 3, breadth: 5)
val.scaleBy(res: 3)
val.scaleBy(res: 30)
val.scaleBy(res: 300)
```

# reference

### 是否提供外部名称设置

我们强制在第一个参数添加外部名称把这个局部名称当作外部名称使用（Swift 2.0前是使用 # 号）。

相反，我们呢也可以使用下划线（_）设置第二个及后续的参数不提供一个外部名称。
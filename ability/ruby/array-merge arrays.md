```ruby
a = [];
b = [0,2];
a.push b;
```
array a of above code will be like:
```
[[0,2]]
```
```ruby
a=[];
b=[0,2];
a.push *b;
```
array a of above code will be like:
```
[0,2]
```
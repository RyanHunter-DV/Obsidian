# How to change the cursor position while printing?
- `\033[3D`, 3D means move cursor left to 3 chars
```
>> echo "\033[1Dhello"
```
more reference:
[formatted print](https://www.cnblogs.com/rain-blog/p/linux-control-cursor-in-terminal.html)

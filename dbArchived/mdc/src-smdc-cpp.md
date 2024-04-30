A program to setup a simple cpp file
# Features
- [[#generate .h and .cpp file separately]]
- [[#]]
- 

*relative links*
- [[src-mainEntry.rb]], the main entry for this tool
# Source Code
**head**
```ruby
#! /usr/bin/env ruby
useVersion = 'v1';
require 'rhload';
$TOOLHOME = File.dirname(File.absolute_path(__FILE__))+'/'+useVersion;
$LOAD_PATH << $TOOLHOME;

rhload 'lib/smdc-cpp/mainEntry.rb';

e = MainEntry.new();
$SIG = e.run();
exit $SIG;
```

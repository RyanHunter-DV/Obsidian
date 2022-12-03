# relative links
- [[rhFlow/rhDeAss/lib/src-mainEntry.rb]]
- 
# Source Code
**head**
```ruby
#! /usr/bin/env ruby
useVersion = 'v1';
require 'rhload';
$TOOLHOME = File.dirname(File.absolute_path(__FILE__))+'/'+useVersion;
$LOAD_PATH << $TOOLHOME;

rhload 'lib/mainEntry.rb';

e = MainEntry.new();
$SIG = e.run();
exit $SIG;
```
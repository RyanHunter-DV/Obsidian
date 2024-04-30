This is shell for simf, different version of this tool will call the same `simf` executor.
# Source Code
**head**
```ruby
useVersion = 'v4';
require 'rhload';
$TOOLHOME = File.dirname(File.absolute_path(__FILE__))+'/'+useVersion;
$LOAD_PATH << $TOOLHOME;

rhload 'lib/mainEntry.rb';

e = MainEntry.new();
$SIG = e.run();
exit $SIG;
```
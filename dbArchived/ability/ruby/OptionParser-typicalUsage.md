# file required
```
require 'optparse'
```

# ref link
https://ruby-doc.org/stdlib-2.7.1/libdoc/optparse/rdoc/OptionParser.html

# Examples
minimal example:
```
options={};
OptionParser.new() do |opt|
	opts.on("-v","--verbose","set verbose") do |v|
		options[:v] = v
end.parse!
```
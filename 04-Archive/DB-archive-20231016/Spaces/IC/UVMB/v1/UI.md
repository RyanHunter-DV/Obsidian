UI object
1. setup options.
2. parse user inputs.
3. execute user actions.

# How to execute user actions?
Actions will be executed like:
```ruby
actions.each do |action|
	container.instance_eval action
end
```
Action format:
```ruby
actions = [];
action = <<-LN.gsub(/^\s+-/,'')
	-Builder.loadSource;
	-Builder.finalize;
	-Builder.publish;
 LN
```
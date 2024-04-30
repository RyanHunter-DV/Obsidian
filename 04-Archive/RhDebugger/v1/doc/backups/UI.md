# Generic options
- `--probe-inject "<path>,<value>,<index>"`, to dynamically inject the override value for a certain probe.
- `--rhdinfo-enable <scope>`, partially enable scope of component to log it, if `--rhdebug` specified, then 
- `--rhdinfo-disable <scope>`

## `--stacktrace`
to enable the stack trace features, from RhdCall, RhdThread, only when this option specified, can the information been logged. This option relies on the `--rhdinfo-enable` option, only when the stack trace option enabled and the certain component has rhdinfo enabled, then can the information being logged.
## `--rhdinfo-*`
This has two separate options, one is for enable while the other one is for disable. This can be used when users want to enable the most of components except some certain ones. For example, users can specify the log feature like: `--rhdinfo-enable uvm_test_top --rhdinfo-disable uvm_test_top.env.vip0`.
By default, the info feature is disabled, if users want enable the whole scope, then can use uvm_test_top to enable all.
## `--probe-inject`
This option used to inject a value for a certain probe, at certain index it been called.
The print feature of probe also relies on the `--rhdinfo-enable` option.
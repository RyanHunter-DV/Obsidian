JIRA link: https://ryanhunter30479.atlassian.net/browse/RHVM-9
This page to enhance the debug switch features, so that users from env can easily enable/disable a dvlib/vip's debug mode;

# debug switch in vip/dvlib
examples:
```
class IPOrSocEnv;
	Vip v0; // IpEnv e0;
	Vip1 v1; //
	build_phase() {
		buildV0();
		buildV1();
	}
}
```


```
class Vip;

	VipConfig config;
	new()

	build_phase()
		config.create();
		config.setupDebug(this);
		drv.create();
		drv.config = config;
	options(opt)
		if (opt=="debug") RhuDebugger::enable(this);

class VipConfig;
	RhuDebugger debug;
	setupDebug(uvm_component obj);
		debug=new(obj,"component");
```



- config an object's debug mode through the `options("debug")` option.
- anytime the option is set, the object will call to enable its debug mode by calling a static API: `RhuDebugger::enable(this)`
- This mechanism finally decided by a config from test level, which can be set dynamically through plusargs.


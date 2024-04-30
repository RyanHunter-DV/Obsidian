# envs
## omos env
This is the env for one master one slave pair. The env can be configured to support random slave responder or custom slave responder.
### file constructs
- `omosEnv`, the env, configures one master and one slave VIP, and connections;
- `omosBaseTest`, the basic test instantiates `omosEnv`;

**env** `omosEnv`
**details** [[Spaces/IC/vips/ahb5/v1/examples/env/omosEnv]]

# tests
## omosBaseTest
The basic test for setting up the omos env.
## omosSingleWriteReadTest
The basic test to write/read a slave like a memory. With single burst. #WIP

**env** `omosEnv`
**details** [[Spaces/IC/vips/ahb5/v1/examples/tests/omosSingleWriteReadTest]]

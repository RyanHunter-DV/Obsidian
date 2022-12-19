# template
**Category** `featureCategory`
**ID** `VRID`
**Description**
```
The description lines
```
**BaseStrategy**
```
the basic test strategy
```
**Stimulus**
```
stimulus
```
**Checker**
```
```
**Coverage**
```
lists which points should be covered
```
**Testname** `testname`
**Owner** `owner`

# Source Code
## basicTransfers
**Category** `basic`

### single burst
**SubKeys** `SINGLE`
**BaseStrategy**
```
Test the basic feature of sending the SINGLE burst, with:
	random address;
	random gaps between two different bursts, 0~200 cycles delay;
	maximum 2000 bursts sent by the test master device;	
```
**Stimulus**
```
1. burst type set to single
2. trans type set to nonseq
3. set delay randomly within 0~200
4. all others are random
```
**Checker**
```
protocol correctiveness, the sent AHB5 packet should be collected corrected by a reference monitor, and will check the packet value is equal with the expected one.
check the delay, if send delay is 0, this packet should only has 1 cycle delayed with previous packet.
```
**Coverage**
```
1. send two bursts with no delay
2. send two bursts with delay
```
**Testname** `rhahb5Mst_basic_SINGLE_test`

## incr burst
**SubKeys** `INCR`
**BaseStrategy**
#TODO 
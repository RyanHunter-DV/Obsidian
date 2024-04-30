
**base** `omosBaseTest`
**config**
- enable custom responder: `env.customResponder`
**simulus**
- RhAhb5SingleBurstSeq seq=new;
- set seq fields as write, fix address, random data;
- seq.start;
- create a new seq;
- set seq fields as read, address same as write
- seq.start;
- compare read/write data, should be same

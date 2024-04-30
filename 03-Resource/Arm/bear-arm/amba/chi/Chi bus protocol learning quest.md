# Chi bus protocol learning quest
#reference/arm/amba/chi
#goal/quests


- [ ] Transaction identifier field flow quests
  - [ ] how’s behave in read transaction?
  - [ ] in dataless transaction?
  - [ ] write trans?
  - [ ] DVMOp trans?
    - [ ] what’s DVMOp?
  - [ ] trans request with retry?
  - [ ] protocol credit return trans?
  - [ ] For a Request packet: TgtID, SrcID, TxnID, StashNID, StashLPID, ReturnNID, ReturnTxnID, PGroupID, StashGroupID, and TagGroupID. 
  - [ ] what’s DMT trans?
  - [x] read trans types?
  - [ ] allocating read?
  - [ ] what’s no snoopable region?
  - [ ] what’s snoop transaction mean and will be used in real transactions?
  - [ ] ReturnNID? mostly used for a SN who received a req coming from an HN but need to return data directly to the initial requester, then ReturnNID will mark out the id of initial requester.

## links
[[network layer overview]]
[[Transaction identifier field flows]]
#marker [[Allocating read]]


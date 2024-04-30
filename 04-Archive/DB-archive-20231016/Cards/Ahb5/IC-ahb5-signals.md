#protocol
# HBURST
- 3-bit value, indicates type of burst:
	- [[#single]] 
	- [[#incr]]
	- wrap4,
	- incr4, 
	- wrap8, 
	- incr8, 
	- wrap16, 
	- incr16
- all incrementing type of burst shall not across the 1KB address boundary

## single
## incr
the undefined length of incrementing, maximum length should not across the 1KB address boundary, which is `0x400`


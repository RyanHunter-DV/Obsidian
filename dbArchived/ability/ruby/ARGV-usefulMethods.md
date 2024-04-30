`ARGV.first`
to get the first name of user command options, not include the executor name, it's the first option after the executor.
`ARGV.each`
like an array, can loop all options in ARGV.
`ARGV.pop`
pop out the last item in ARGV
`ARGV.shift`
pop out the first item in ARGV
```
path = ARGV.shift; ## if ARGV has [a,b,c], then path is a, ARGV remains b,c
```


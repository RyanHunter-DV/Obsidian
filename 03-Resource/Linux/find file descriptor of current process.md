>/proc/[PID]/fd is one of such directory containing one entry for each file which the process has open, named by its file descriptor, and which is a symbolic link to the actual file. Thus, 0 is standard input, 1 standard output, 2 standard error, 3 /etc/resolv.conf, 4 /tmp/output.txt etc.



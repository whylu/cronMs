Schedule jobs in seconds period

Installation:
 downolad from git

Run:
----
./cronMs.sh start 

Stop:
-----
./cronMs.sh start 

Show Status:
------------
./cronMs.sh status


Config period of command:
-------------------------
edit ./config file fomated as follwoing
<interval> <command>

for example:
5 /opt/workspace/cronMs/a/run


Working
-------
At "./cronMs.sh start", cronMs read this file and run every <command> by <interval> second period,
and put process pids into ./startpid/ folder,
and echo "pid, interval, command" >> ./status

At "./cronMs.sh stop", cronMs remove every process by the ./startpid/ filename

At "./cronMs.sh status", cronMs cat ./status


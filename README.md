Schedule jobs in seconds period



Installation:
-------------
downolad from git
go into cronMs folder, create a folder named "startpid"
> mkdir startpid




Run:
----
> ./cronMs.sh start 


Stop:
-----
> ./cronMs.sh stop


Show Status:
------------
> ./cronMs.sh status


Config period of command:
-------------------------
edit ./config file fomated as follwoing
> {interval} {command}

for example:
> 5 /opt/workspace/cronMs/a/run

cronMs use "sleep {interval}" to get into idle, 
you can using any decimal number to asign sleep interval, for example:
> 0.5 <commnad>


Working
-------
At "./cronMs.sh start", cronMs read this file and run every {command} by {interval} second period,
and put process pids into ./startpid/ folder,
and echo "pid, interval, command" into ./status


CronMs create another thread to read a line, executes a command, and sleep {interval} second, 
then repeat execute and sleep foever, until "./cronMs.sh stop" executed.
The execution of command and sleep command start at the same time, so, if execution time of command large than sleep, you will get more than one execution process of {command} at the same time.


At "./cronMs.sh stop", cronMs remove every process by the ./startpid/ filename

At "./cronMs.sh status", cronMs cat ./status


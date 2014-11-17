
# the install path
cronMs_path=$(pwd)

# the config path
config=$cronMs_path/config

# the pid file folder path of running process
startpid=$cronMs_path/startpid

# the status file path
status=$cronMs_path/status


# $1 => pid
# $2 => call interval time in second
# $3 => command
function addStatus() {
    echo pid: $1,  interval: $2 s,  command: $3 >> $status
}


# $1 => call interval time in second
# $2 => command
function call_endless_loop() {
    fullLine=$@
    set -- $fullLine
    interval=$1
    shift
    command=$@
        
    echo $BASHPID start
    touch $startpid/$BASHPID
    addStatus $BASHPID $1 $2
    while true;
    do
        $("$command") &
        sleep $interval
    done
}


function cron_start() {
    while read line; do
        set -- $line
        interval=$1
        shift
        command=$@
        if [ "$interval" > "0" ]; then
            call_endless_loop $interval $command &
        fi
    done < $config
}

function cron_stop() {
    if [ "$(ls -A $startpid)" ]; then        
        for file in $startpid/*;
        do
            echo kill "$(basename $file)"
            kill -TERM "$(basename $file)"
            rm -f $file
        done
    else
        echo no pid to kill
    fi
    > $status
}


case "$1" in
    start)
        echo "start..."
        cron_stop
        cron_start&
    ;;
    stop)
        echo "stop..."
        cron_stop
    ;;
    status)
        echo "pid | interval |  command"
        cat $status
    ;;
    *)
        echo "Usage $0 (start | stop | status)"
    ;;
esac



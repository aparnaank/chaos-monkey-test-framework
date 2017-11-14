#!/bin/bash


while getopts k:p:o: option
do
 case "${option}"
 in
 p) path=${OPTARG};;
 k) killSvr=${OPTARG};;
 o) operation=${OPTARG};;
 esac
done


function serverOperations(){
echo $operation
echo $path
./$path/bin/wso2server.sh $operation

}

function serverKill(){
    PID=`ps -A |grep wso2| awk '{print $1}'`
    echo $PID
    kill -9 $PID
}

function help_message() {
    echo ""
	echo "Restarting server"
	echo "./makeStress.sh -c [no of cpu] -t [duration N ]"
	echo ""
	echo ""
	echo "Kill server"
	echo "./makeStress.sh -k kill-server"
	echo ""
	exit
}


if [ "$killSvr" == "kill-server" ];
    then
	#log "INFO" "Stressing CPU tests running $CPU"
	serverKill
fi

if [ "$path" != "" ] && [ "$operation" != "" ];
    then
	#log "INFO" "Stressing CPU tests running $CPU"
	serverOperations
fi



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
    sh $path/bin/wso2server.sh $operation

}

function serverKill(){
    PID=`jps | grep Bootstrap | awk '{ print $1 }'`
    kill -9 ${PID}
}

function help_message() {
    echo ""
	echo "Restarting server"
	echo "./makeStress.sh -p [instance path] -t [duration N ]"
	echo ""
	echo ""
	echo "Kill server"
	echo "./makeStress.sh -k killSvr"
	echo ""
	exit
}


if [ "$killSvr" == "killSvr" ];
    then
	#log "INFO" "Stressing CPU tests running $CPU"
	serverKill
fi

if [ "$path" != "" ] && [ "$operation" != "" ];
    then
	#log "INFO" "Stressing CPU tests running $CPU"
	serverOperations
fi



#!/bin/bash

while getopts a:d:u:s: option
do
 case "${option}"
 in
 a) networkAdaptor=${OPTARG};;
 d) downRate=${OPTARG};;
 u) upRate=${OPTARG};;
 s) networkSet=${OPTARG};;
 esac
done

function networkFluctuate() {
echo $networkAdaptor
echo $downRate
echo $downRate
sudo wondershaper -a $networkAdaptor -d $downRate -u $downRate
}

function cleanUpNetworkFluctuate() {
sudo wondershaper clear $networkAdaptor
}

function networkUpDown(){
ip link set $networkAdaptor $networkSet
}

#function networkUp(){
#ip link set $NetworkAdaptor up
#}

function help_message() {
    echo "Limit the bandwidth of an adapter"
	echo "./makeNetworkFluctuation.sh -a [network adapter] -d [download rate] -u [uplaod rate]"
	echo ""
	echo "Clean up the bandwidth limitation"
	echo "./makeNetworkFluctuation.sh -a [network adapter]"
	echo ""
	echo "Stop the network adaptor"
	echo "./makeNetworkFluctuation.sh -a [network adapter] -s [down]"
	echo ""
	echo "Start the network adaptor"
	echo "./makeNetworkFluctuation.sh -a [network adapter] -s [up]"
	echo ""
	exit
}

if [ "$1" == "help" ];then
	help_message
fi

if [ "$networkAdaptor" == "" ] || [ "$downRate" == "" ] || [ "$upRate" == "" ];
    then
	#log "INFO" "No CPU or IO or Disk or Memory or VM or Time specified!"
	#log "INFO" "You need to try HELP!!!"
	help_message
fi

if [ "$networkAdaptor" != "" ] && [ "$downRate" != "" ] && [ "$upRate" != "" ];
    then
	#log "INFO" "Stressing CPU tests running $CPU"
	networkFluctuate
fi

if  [ "$networkAdaptor" != "" ];
    then
	#log "INFO" "Stressing CPU tests running $CPU"
	cleanUpNetworkFluctuate
fi

if [ "$networkAdaptor" != "" ] && [ "$networkSet" != "" ];
    then
	#log "INFO" "Stressing CPU tests running $CPU"
	networkUpDown
fi


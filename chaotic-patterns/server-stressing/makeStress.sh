#!/bin/bash

#CPU = $ARGUMENTS['c']
#IO = $ARGUMENTS['i']
#DISK = $ARGUMENTS['d']
#DURATION = $ARGUMENTS['t']
#VM_BYTES = $ARGUMENTS['m']
#VM = $ARGUMENTS['v']

#getopt -c CPU
#getopt -t DURATION

while getopts c:i:d:t:m:v: option
do
 case "${option}"
 in
 c) CPU=${OPTARG};;
 i) IO=${OPTARG};;
 d) DISK=${OPTARG};;
 t) DURATION=${OPTARG};;
 m) VM_BYTES=${OPTARG};;
 v) VM=${OPTARG};;
 esac
done


function stressCPU() {
stress --cpu $CPU --timeout $DURATION's' --verbose
}

function stressIO() {
stress --io ${IO} --timeout ${DURATION}'s' --verbose
}

function stressDisk() {
stress --d ${DISK} --timeout ${DURATION}'s' --verbose
}

function stressMemory() {
stress --vm-bytes ${VM_BYTES} --timeout ${DURATION}'s' --verbose
}

function stressVM() {
stress --vm ${VM} --timeout ${DURATION}'s' --verbose
}

function stressAll() {
stress --cpu ${CPU} --io ${IO} --d ${DISK} --vm ${VM} --vm-bytes ${VM_BYTES}M --timeout ${DURATION}'s' --verbose
}

function help_message() {
	echo "Spawn CPU"
	echo "./makeStress.sh -c [no of cpu] -t [duration N ]"
	echo ""
	echo "Spawn IO"
	echo "./makeStress.sh -i [no of io] -t [duration N ]"
	echo ""
	echo "Spawn DISK"
	echo "./makeStress.sh -d [no of disk utilization] -t [duration N ]"
	echo ""
	echo "Spawn Memory"
	echo "./makeStress.sh -m [no of memory utilization] -t [duration N ]"
	echo ""
	echo "Spawn VMs"
	echo "./makeStress.sh -v [no of vms] -t [duration N ]"
	echo ""
	echo "Spawning all parameters"
	echo "./makeStress.sh -c [no of cpu] -i [no of io] -d [no of disk utilization] -m [no of memory utilization] -v [no of vms] -t [duration N ]"
	echo ""
	exit
}

if [ "$1" == "help" ];then
	help_message
fi

if ["$CPU" == ""] || ["$IO" == ""] || ["$DISK" == ""] || ["$VM" == ""] || ["$VM_BYTES" == ""] || ["$DURATION" == ""]; then
	#log "INFO" "No CPU or IO or Disk or Memory or VM or Time specified!"
	#log "INFO" "You need to try HELP!!!"
	help_message
fi

if [ "$CPU" != "" ] && [ "$DURATION" != "" ];
    then
	#log "INFO" "Stressing CPU tests running $CPU"
	echo $CPU
    echo $DURATION
	stressCPU

elif [ "$IO" != "" ] && [ "$DURATION" != "" ];
    then
    #log "INFO" "Stressing IO test running $IO"
    echo $IO
    echo $DURATION
    stressIO

elif [ "$DISK" != "" ] && [ "$DURATION" != "" ];
    then
    #log "INFO" "Stressing IO test running $DISK"
    stressDisk

elif [ "$VM" != "" ] && [ "$DURATION" != "" ];
    then
    #log "INFO" "Stressing IO test running $VM"
    stressVM

elif [ "$VM_BYTES" != "" ] && [ "$DURATION" != "" ];
    then
    #log "INFO" "Stressing IO test running $VM_BYTES"
    stressMemory

elif [ "$CPU" != "" ] && [ "$IO" != "" ] && [ "$DISK" != "" ] && [ "$VM" != "" ] && [ "$VM_BYTES" != "" ] && [ "$DURATION" != "" ];
    then
	#log "INFO" "Stressing IO test running $CPU $IO $DISK $VM $VM_BYTES"
    stressAll
fi
#!/bin/bash

CPU=$ARGUMENTS[c]
IO=$ARGUMENTS[i]
DISK=$ARGUMENTS[d]
DURATION=$ARGUMENTS[t]
VM_BYTES=$ARGUMENTS[m]
VM=$ARGUMENTS[v]

function stressCPU() {
stress --cpu ${CPU} --timeout ${DURATION}s --verbose
}

function stressIO() {
stress --io ${IO} --timeout ${DURATION}s --verbose
}

function stressDisk() {
stress --d ${DISK} --timeout ${DURATION}s --verbose
}

function stressMemory() {
stress --vm-bytes ${VM_BYTES} --timeout ${DURATION}s --verbose
}

function stressVM() {
stress --vm ${VM} --timeout ${DURATION}s --verbose
}

function stressAll() {
stress --cpu ${CPU} --io ${IO} --d ${DISK} --vm ${VM} --vm-bytes ${VM_BYTES}M --timeout ${DURATION}s --verbose
}

function help_message() {
	echo "Spawn CPU"
	echo "./makeStress.sh -c [no of cpu] -t [duration N ]"
	echo ""
	echo "Spawning all parameters"
	echo "./makeStress.sh -c [no of cpu] -i [] -d [] -t [duration N ]"
	echo ""
	exit
}

#if [ "$1" == "help" ];then
#	help_message
#fi

if [ "$CPU" == "" ] || [ "$IO" == "" ] || [ "$DISK" == "" ] || [ "$VM" == "" ] || [ "$VM_BYTES" == "" ] || [ "$DURATION" == "" ]; then
	#log "INFO" "No CPU or IO or Disk or Memory or VM or Time specified!"
	#log "INFO" "You need to try HELP!!!"
	help_message
fi

if [ "$CPU" != "" ] && [ "$DURATION" != "" ]; then
	#log "INFO" "Stressing CPU tests running $CPU"
		stressCPU
elif ["$IO" !=""] && [ "$DURATION" != "" ]; then
    #log "INFO" "Stressing IO test running $IO"
        stressIO
elif ["$DISK" != ""] && [ "$DURATION" != "" ]; then
    #log "INFO" "Stressing IO test running $DISK"
        stressDisk
elif ["$VM" != ""] && [ "$DURATION" != "" ]; then
    #log "INFO" "Stressing IO test running $VM"
        stressVM
elif ["$VM_BYTES" != ""] && [ "$DURATION" != "" ]; then
    #log "INFO" "Stressing IO test running $VM_BYTES"
        stressMemory
elif [ "$CPU" != "" ] && [ "$IO" != "" ] && [ "$DISK" != "" ] && [ "$VM" != "" ] && [ "$VM_BYTES" != "" ] && [ "$DURATION" != "" ]; then
	#log "INFO" "Stressing IO test running $CPU $IO $DISK $VM $VM_BYTES"
        stressAll
fi
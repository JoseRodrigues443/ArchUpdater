 #!/bin/bash
 
 #
 #  THIS APLICATION IS A TOOL TO UPDATE AN ARCH LINUX SYSTEM IN A EASY WAY.
 #  IT USES PACMAN AND YAOURT (AUR PACKAGES)
 #
 #
 #
 #
 #
 

 
echo _________
echo Check root
echo _________
if [[ $UID == 0 ]]; then
		echo "Please run this script WITHOUT sudo:"
		echo "$0 $*"
		exit 1
fi

echo ________
echo pacman -Syu
echo ________
sudo pacman -Syu


echo ________
echo Clean System: pacman -Sc && pacman -Scc
echo ________

pacman -Sc
pacman -Scc


echo ______________
echo List Orphans packages
echo ______________
orphansPack=$(sudo pacman -Qdt)

if [ -z "$orphansPack" ]
then
		echo No oprhans
else
		echo __________
		echo Remove Orphans
		echo __________
		sudo pacman -Rsn $(sudo pacman -Qdtq)
fi

echo _____________________________________
read -e -p "Should I update AUR Packages? (With no confirm)" -i "Y" REPLY
echo _____________________________________
if [[ $REPLY =~ ^[Yy]$ ]]
then
		#sudo echo "SUDO HACK"
		user=$(whoami)
		echo "Change user to '\$(whoami)'"
		#no confirm will not the annoy the user with pkbuild edit warnings
		yaourt -Syua --noconfirm
fi

if ! [ -x "$(command -v bleachbit)" ]; then
  echo 'Error: bleachbit is not installed.' >&2
  exit 1
fi


echo _____________________________________
read -e -p "Should I use bleachbit to clean system [it may take a while]? (With no confirm)" -i "Y" REPLY
echo _____________________________________
if [[ $REPLY =~ ^[Yy]$ ]]
then
	bleachbit --list | grep -E "[a-z]+\.[a-z]+" | grep -v system.free_disk_space | xargs bleachbit --clean
fi

exit 0









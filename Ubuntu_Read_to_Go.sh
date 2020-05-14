#!/bin/bash
#Fixing "W: Possible missing firmware /lib/firmware/i915/kbl_guc_ver9_14.bin for module i915"
codename=$(lsb_release --codename --short)
if [ $codename == "xenial" ]
then
	sudo apt install wget
	wget https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/i915/kbl_guc_ver9_14.bin
	wget https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/i915/bxt_guc_ver8_7.bin
	sudo chmod 644 bxt_guc_ver8_7.bin kbl_guc_ver9_14.bin
	sudo chown root:root bxt_guc_ver8_7.bin kbl_guc_ver9_14.bin
	sudo mv bxt_guc_ver8_7.bin kbl_guc_ver9_14.bin /lib/firmware/i915
else
	echo "isn't xenial"
fi
sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y
#Download Git for Linux and Unix
sudo apt purge git -y
sudo apt autoremove -y
sudo add-apt-repository ppa:git-core/ppa -y
sudo apt update && sudo apt install git -y
#Install Redshift Daily Builds 
codename=$(lsb_release --codename --short)
if [ $codename == "xenial" ]
then
	sudo add-apt-repository ppa:dobey/redshift-daily -y
	sudo apt install geoclue-2.0
	sudo apt update && sudo apt install redshift-gtk -y
else
	echo "Night light is already supported"
fi
#Install Mercurial
codename=$(lsb_release --codename --short)
if [ $codename == "xenial" ]
then
	sudo add-apt-repository ppa:mercurial-ppa/releases -y
	sudo apt update && sudo apt install mercurial -y
else
	sudo apt install mercurial -y
fi
#Spotify for Linux
sudo apt install curl -y
curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt update && sudo apt install spotify-client -y
#Chromium stable
codename=$(lsb_release --codename --short)
if [ $codename == "focal" ]
then
	echo "There is no support for Chromium Browser in Focal Fossa"
else
	sudo add-apt-repository ppa:chromium-team/stable -y
	sudo apt update && sudo apt install chromium-browser -y
	codename=$(lsb_release --codename --short)
	if [ $codename == "xenial" ]
	then
		sudo apt install unity-chromium-extension
	else
		sudo apt install chrome-gnome-shell
	fi
	
fi
#Only in GnomeUbuntu
#lsb_release -i --flavour
#if [ $GnomeUbuntu ]
#then
	#sudo apt-get install chrome-gnome-shell -y
#else
    	#echo "GNOME Shell integration for Chrome already supported"
#fi
#qBittorrent Stable
sudo add-apt-repository ppa:qbittorrent-team/qbittorrent-stable -y
sudo apt update && sudo apt install qbittorrent -y
#Firefox ESR
sudo apt purge firefox firefox-locale-en firefox-locale-pt unity-scope-firefoxbookmarks -y
sudo add-apt-repository ppa:mozillateam/ppa -y
sudo apt update && sudo apt install firefox-esr firefox-esr-locale-pt
#Installing LibreOffice on Linux
sudo apt purge libreoffice-common -y
sudo add-apt-repository ppa:libreoffice/ppa -y
sudo apt update && sudo apt install libreoffice-common libreoffice-help-pt-br libreoffice-l10n-pt-br -y
#Gaming Packages
codename=$(lsb_release --codename --short)
if [ $codename == "xenial" ]
then
	echo "No DXVK support"
else
	#Installing DXVK
	codename=$(lsb_release --codename --short)
	if [ $codename == "bionic" ]
	then
		sudo add-apt-repository ppa:kisak/kisak-mesa -y
		sudo dpkg --add-architecture i386
		sudo apt update && sudo apt upgrade -y
		sudo apt install libgl1-mesa-glx:i386 libgl1-mesa-dri:i386 -y
		sudo apt install mesa-vulkan-drivers mesa-vulkan-drivers:i386 -y
	else
		sudo dpkg --add-architecture i386
		sudo apt update && sudo apt install libgl1-mesa-dri:i386
		sudo apt install mesa-vulkan-drivers mesa-vulkan-drivers:i386
	fi
	#WineHQ Binary Packages
	sudo dpkg --add-architecture i386
	wget -O - https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add -
	codename=$(lsb_release --codename --short)
	if [ $codename == "bionic" ]
	then
		sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main' -y
	else
		sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main' -y
	fi
	sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y
	sudo apt install --install-recommends winehq-staging
	#Stable releases for the Lutris client
	sudo add-apt-repository ppa:lutris-team/lutris -y
	sudo apt update && sudo apt install lutris -y
	#Steam Install
	sudo add-apt-repository multiverse
	sudo apt update && sudo apt install steam -y
fi
#Install Julia, Atom and Juno
codename=$(lsb_release --codename --short)
if [ $codename == "focal" ]
then
	sudo apt install julia -y
	wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
	sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'
	sudo apt update && sudo apt install atom
else
	echo "The avaiable Julia package in repository is outdated"
fi

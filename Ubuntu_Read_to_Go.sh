#!/bin/bash
#Fixing "W: Possible missing firmware /lib/firmware/i915/kbl_guc_ver9_14.bin for module i915"
lsb_release -c
if [ $"Codename:	xenial" ]
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
sudo add-apt-repository ppa:git-core/ppa -y
sudo apt update
sudo apt install git -y
#Spotify for Linux
sudo apt install curl
curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt update
sudo apt install spotify-client -y
#Chromium stable
lsb_release -c
if [ $"Codename:	focal" ]
then
	echo "There is no support for Chromium Browser in Focal Fossa"
else
	sudo add-apt-repository ppa:chromium-team/stable -y
	sudo apt update
	sudo apt install chromium-browser -y
fi
#Only in GnomeUbuntu
:'lsb_release --id
if [ $"Codename:	GnomeUbuntu" ]
then
	sudo apt-get install chrome-gnome-shell -y
else
    echo "GNOME Shell integration for Chrome already supported"
fi
'
#qBittorrent Stable
sudo add-apt-repository ppa:qbittorrent-team/qbittorrent-stable -y
sudo apt update
sudo apt install qbittorrent -y
#Firefox ESR
sudo apt purge firefox firefox-locale-en firefox-locale-pt unity-scope-firefoxbookmarks -y
sudo add-apt-repository ppa:mozillateam/ppa -y
sudo apt update
sudo apt install firefox-esr firefox-esr-locale-pt
#Installing LibreOffice on Linux
sudo apt purge libreoffice-common -y
sudo add-apt-repository ppa:libreoffice/ppa -y
sudo apt update
sudo apt install libreoffice-common libreoffice-help-pt-br libreoffice-l10n-pt-br -y
#Gaming Packages
lsb_release -c
if [ $"Codename:	bionic" ]
then
	#Installing DXVK
	sudo add-apt-repository ppa:kisak/kisak-mesa
	sudo dpkg --add-architecture i386
	sudo apt update && sudo apt upgrade
	sudo apt install libgl1-mesa-glx:i386 libgl1-mesa-dri:i386
	sudo apt install mesa-vulkan-drivers mesa-vulkan-drivers:i386
	#WineHQ Binary Packages
	sudo dpkg --add-architecture i386
	wget -O - https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add -
	sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main'
	sudo apt update
	sudo apt install --install-recommends winehq-staging
	#Stable releases for the Lutris client
	sudo add-apt-repository ppa:lutris-team/lutris
	sudo apt-get update
	sudo apt-get install lutris
	#Steam Install
	sudo add-apt-repository multiverse
	sudo apt update
	sudo apt install steam
else
	echo "No DXVK support"
fi
#Install Julia, Atom and Juno
lsb_release -c
if [ $"Codename:	focal" ]
then
	sudo apt install julia
	wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
	sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'
	sudo apt update
	sudo apt install atom
else
	echo "The avaiable Julia package in repository is outdated"
fi

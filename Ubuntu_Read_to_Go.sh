#!/bin/bash
sudo apt install wget			#Package downloader
sudo apt install gdebi			#Debian package installer
sudo apt install ppa-purge		#PPA remover
sudo apt-get install openjdk-11-jdk	#Install Java Development Kit
#GUI utility to change the CPU frequency
codename=$(lsb_release --codename --short)
if [ $codename == "focal" ]
then
	sudo apt install cpupower-gui
fi
#Building and istalling OSS4
sudo apt install build-essential gcc binutils make gawk libgtk2.0-0 libgtk2.0-dev libcanberra-gtk-module libtool libsdl1.2debian libsdl1.2-dev
wget http://www.4front-tech.com/developer/sources/stable/gpl/oss-v4.2-build2020-src-gpl.tar.bz2

./configure
make
sudo checkinstall
#sudo apt install liboss4-salsa-asound2 liboss4-salsa2 oss4-base oss4-dev oss4-dkms oss4-gtk oss4-source
#Fixing missing firmwares
case codename=$(lsb_release --codename --short) in
xenial)
	#Fixing "W: Possible missing firmware /lib/firmware/i915/kbl_guc_ver9_14.bin for module i915"
	#Fixing "W: Possible missing firmware /lib/firmware/i915/kbl_guc_ver8_7.bin for module i915"
	wget https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/i915/kbl_guc_ver9_14.bin
	wget https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/i915/bxt_guc_ver8_7.bin
	sudo chmod 644 bxt_guc_ver8_7.bin kbl_guc_ver9_14.bin
	sudo chown root:root bxt_guc_ver8_7.bin kbl_guc_ver9_14.bin
	sudo mv bxt_guc_ver8_7.bin kbl_guc_ver9_14.bin /lib/firmware/i915
	;;
bionic)
	#Fixing "W: Possible missing firmware /lib/firmware/rtl_nic/rtl8125a-3.fw for module r8169"
	#Fixing "W: Possible missing firmware /lib/firmware/rtl_nic/rtl8168fp-3.fw for module r8169"
	wget https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/rtl_nic/rtl8125a-3.fw
	wget https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/rtl_nic/rtl8168fp-3.fw
	sudo chmod 644 rtl8125a-3.fw rtl8168fp-3.fw
	sudo chown root:root rtl8125a-3.fw rtl8168fp-3.fw
	sudo mv rtl8125a-3.fw rtl8168fp-3.fw /lib/firmware/rtl_nic
	;;
esac
sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y
#Disabling Snaps in Ubuntu 20.04 LTS
codename=$(lsb_release --codename --short)
if [ $codename == "focal" ]
then
	#Remove existing Snaps
	sudo snap remove snap-store
	sudo snap remove gtk-common-themes
	sudo snap remove gnome-3-34-1804
	sudo snap remove core18
	sudo snap remove snapd
	#Remove and purge the snapd package
	sudo apt purge snapd
	#Remove any lingering snap directories
	rm -rf ~/snap
	sudo rm -rf /snap
	sudo rm -rf /var/snap
	sudo rm -rf /var/lib/snapd
fi
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
	sudo apt install geoclue-2.0 -y
	sudo apt update && sudo apt install redshift-gtk -y
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
#Chromium stable[DEPRECATED]
#codename=$(lsb_release --codename --short)
#if [ $codename == "focal" ]
#then
#	echo "There is no support for Chromium Browser in Focal Fossa"
#else
#	sudo add-apt-repository ppa:chromium-team/stable -y
#	sudo apt update && sudo apt install chromium-browser -y
#	codename=$(lsb_release --codename --short)
#	if [ $codename == "xenial" ]
#	then
#		sudo apt install unity-chromium-extension
#	else
#		sudo apt install chrome-gnome-shell
#	fi
#	
#fi
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
sudo apt purge firefox firefox-locale-en firefox-locale-pt -y
sudo apt purge unity-scope-firefoxbookmarks -y
sudo add-apt-repository ppa:mozillateam/ppa -y
sudo apt update && sudo apt install firefox-esr firefox-esr-locale-pt -y
#Installing LibreOffice on Linux
sudo apt purge libreoffice-common -y
sudo add-apt-repository ppa:libreoffice/ppa -y
#Uncomment the line below to install the PPA version
#sudo apt update && sudo apt install libreoffice-common libreoffice-help-pt-br libreoffice-l10n-pt-br -y
#Gaming Packages
codename=$(lsb_release --codename --short)
if [ $codename == "bionic" -o "focal" ]
then
	#Enabling DXVK
	if [ $codename == "bionic" ]
	then
		sudo apt-get install --install-recommends linux-generic-hwe-18.04 xserver-xorg-hwe-18.04
	fi
	sudo add-apt-repository ppa:kisak/kisak-mesa -y
	sudo dpkg --add-architecture i386
	sudo apt update && sudo apt upgrade -y
	sudo apt install libgl1-mesa-glx:i386 -y
	sudo apt install mesa-vulkan-drivers mesa-vulkan-drivers:i386 -y
fi
#WineHQ Binary Packages
sudo dpkg --add-architecture i386
wget -nc https://dl.winehq.org/wine-builds/winehq.key
sudo apt-key add winehq.key	
case codename=$(lsb_release --codename --short) in
xenial)
	sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ xenial main' -y
	;;
bionic)
	sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main' -y
	;;
focal)
	sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main' -y
	;;
esac
sudo apt update
sudo apt install --install-recommends winehq-staging
#Stable releases for the Lutris client
sudo add-apt-repository ppa:lutris-team/lutris -y
sudo apt update
sudo apt install lutris -y
#Spotify for Linux
sudo apt install curl -y
curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add - 
curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add - 
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update && sudo apt-get install spotify-client -y
#Install Julia
wget https://julialang-s3.julialang.org/bin/linux/x64/1.0/julia-1.0.5-linux-x86_64.tar.gz
tar zxvf julia-1.0.5-linux-x86_64.tar.gz
#Install Atom
wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'
sudo apt-get update
sudo apt-get install atom

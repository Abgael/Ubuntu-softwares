#!/bin/bash

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

#Gaming Packages
codename=$(lsb_release --codename --short)
if [ $codename == "bionic" -o "focal" ]
then
	#Enabling DXVK
	if [ $codename == "bionic" ]
	then
		sudo apt-get install --install-recommends linux-generic-hwe-18.04 xserver-xorg-hwe-18.04
	fi
	sudo add-apt-repository ppa:kisak/turtle
	sudo dpkg --add-architecture i386
	sudo apt update
	sudo apt upgrade
	#Intel drivers
	sudo apt install mesa-vulkan-drivers libglx-mesa0:i386 mesa-vulkan-drivers:i386 libgl1-mesa-dri:i386
	#test
	sudo apt install vulkan-tools
fi

#Installing utilities
sudo apt install i965-va-driver-shaders libva-drm2 libva-x11-2 vainfo	#Video acceleration
sudo apt install ubuntu-restricted-extras		#Commonly used media codecs and fonts for Ubuntu
sudo apt install wget					#The non-interactive network downloader
sudo apt install curl -y				#transfer a URL
sudo apt install synaptic				#graphical management of software packages
sudo apt install gdebi					#Simple tool to install deb files
sudo apt install ppa-purge				#disables a PPA and reverts to official packages
sudo apt install openjdk-11-jdk -y			#Install Java Development Kit

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

#qBittorrent Stable
sudo add-apt-repository ppa:qbittorrent-team/qbittorrent-stable -y
sudo apt update && sudo apt install qbittorrent -y
:'
#Firefox ESR and Thunderbird
sudo apt purge firefox firefox-locale-en firefox-locale-pt -y
sudo apt purge unity-scope-firefoxbookmarks -y
sudo add-apt-repository ppa:mozillateam/ppa -y
sudo apt update && sudo apt install firefox-esr-locale-pt -y
sudo apt install thunderbird-locale-pt-br
#Installing LibreOffice on Linux
sudo apt purge libreoffice-common -y
'
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
curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo apt-key add - 
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt update
sudo apt install spotify-client -y

#VLC media player
sudo apt install vlc -y

#Rhythmbox
sudo apt install rhythmbox -y

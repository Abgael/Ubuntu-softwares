#!/bin/bash
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
	sudo apt purge snapd -y
	#Remove any lingering snap directories
	rm -rf ~/snap
	sudo rm -rf /snap
	sudo rm -rf /var/snap
	sudo rm -rf /var/lib/snapd
fi
sudo apt install wget			#The non-interactive network downloader
sudo apt install curl -y		#transfer a URL
sudo apt install synaptic		#graphical management of software packages
sudo apt install gdebi			#Simple tool to install deb files
sudo apt install ppa-purge		#disables a PPA and reverts to official packages
sudo apt install openjdk-11-jdk -y	#Install Java Development Kit
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
#Firefox ESR and Thunderbird
sudo apt purge firefox firefox-locale-en firefox-locale-pt -y
sudo apt purge unity-scope-firefoxbookmarks -y
sudo add-apt-repository ppa:mozillateam/ppa -y
sudo apt update && sudo apt install firefox-esr-locale-pt -y
sudo apt install thunderbird-locale-pt-br
#Installing LibreOffice on Linux
sudo apt purge libreoffice-common -y
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
sudo apt-get update && sudo apt-get install spotify-client
#VLC media player
sudo apt install vlc
#Rhythmbox
sudo apt install rhythmbox
: '
#Install Julia
wget https://julialang-s3.julialang.org/bin/linux/x64/1.0/julia-1.0.5-linux-x86_64.tar.gz
tar zxvf julia-1.0.5-linux-x86_64.tar.gz
#Install Atom
wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'
sudo apt update
sudo apt install atom
# KVM/Installation
#Installation of KVM
sudo apt install cpu-checker
sudo apt install qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils
sudo apt install virt-viewer
#Add Users to Groups
sudo adduser `id -un` libvirt
sudo adduser `id -un` kvm
#Optional: Install virt-manager (graphical user interface)
sudo apt-get install virt-manager
'

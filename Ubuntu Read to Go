#!/bin/bash
sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y
#Fixing "W: Possible missing firmware /lib/firmware/i915/kbl_guc_ver9_14.bin for module i915"
wget https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/i915/kbl_guc_ver9_14.bin
wget https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/i915/bxt_guc_ver8_7.bin
sudo mv bxt_guc_ver8_7.bin kbl_guc_ver9_14.bin /lib/firmware/i915
sudo chmod 644 bxt_guc_ver8_7.bin kbl_guc_ver9_14.bin
sudo chown root:root bxt_guc_ver8_7.bin kbl_guc_ver9_14.bin
#Download Git for Linux and Unix
sudo add-apt-repository ppa:git-core/ppa
sudo apt update
sudo apt install git
#Spotify for Linux
sudo apt install curl
curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt update
sudo apt install spotify-client
#Chromium stable
sudo add-apt-repository ppa:chromium-team/stable
sudo apt update
sudo apt install chromium-browser
#qBittorrent Stable
sudo add-apt-repository ppa:qbittorrent-team/qbittorrent-stable
sudo apt update
sudo apt install qbittorrent
#Firefox ESR
sudo apt purge firefox firefox-locale-en firefox-locale-pt
sudo add-apt-repository ppa:mozillateam/ppa
sudo apt update
sudo apt install firefox-esr firefox-esr-locale-pt

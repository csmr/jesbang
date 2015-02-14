#!/bin/bash

# Wallyinstall v0.1 - Debian netinstall to #! theme
# First install debian netinstall, no desktops, login (end up at terminal)
# Download this script to file:
#  $ wget -O wally.sh 
# enable running it with 
#  $ sudo chmod +x wally.sh
# and run it with:
#  $ ./wally.sh

# Part I
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install policykit-1

sudo apt-get install apt-listbugs

# Generic

#get compression utilities
sudo apt-get install unrar unace unalz unzip lzop rzip zip xz-utils arj bzip2

# Desktop
sudo apt-get install xorg
sudo apt-get install --no-install-recommends openbox obconf thunar

sudo apt-get install --no-install-recommends lightdm obmenu thunar-volman desktop-base python-xdg tint2 suckless-tools gmrun nitrogen hsetroot conky-all compton

sudo apt-get install --no-install-recommends clipit xfce4-power-manager geany lxappearance xfce4-notifyd libnotify-bin gksu synaptic zenity arandr xinput viewnior geeqie scrot

sudo apt-get install --no-install-recommends wireless-tools firmware-linux firmware-iwlwifi firmware-ralink firmware-ipw2x00 firmware-realtek intel-microcode amd64-microcode user-setup ntp curl xsel xdotool htop fbxkb

sudo apt-get install --no-install-recommends fonts-dejavu fonts-droid ttf-freefont ttf-liberation ttf-mscorefonts-installer gdebi gparted file-roller e2fsprogs xfsprogs reiserfsprogs reiser4progs jfsutils ntfs-3g fuse gvfs-fuse fusesmb dmz-cursor-theme gtk2-engines-murrine gtk2-engines-pixbuf gtk2-engines

# 
sudo apt-get install terminator network-manager-gnome network-manager-openvpn-gnome network-manager-pptp-gnome network-manager-vpnc-gnome

# Make sure we have Virtual Richard Stallman aboard!
sudo apt-get install vrms

# sudo style gksu
# make sure gksu runs in sudo mode
sudo update-alternatives --set libgksu-gconf-defaults /usr/share/libgksu/debian/gconf-defaults.libgksu-sudo
sudo update-gconf-defaults
# Part I - end



# Part II
#- Set up local apt-repository
sudo apt-get install dpkg-dev
sudo mkdir -p /var/local/debs
# local debs
sudo echo "deb file:///var/local/debs ./" > walsrc.list
sudo mv walsrc.list /etc/apt/sources.list.d/debian-wally-sources.list
mkdir -p ~/downloads/debs 
# get packages
wget -nd -P ~/downloads/debs http://packages.crunchbang.org/waldorf/pool/main/{cb-lock_0.01_all.deb,cb-tint2_0.01_all.deb,crunchbang-wallpapers_1.0-1_all.deb,faenza-crunchbang-icon-theme_1.2-crunchang1_all.deb}
wget -P ~/downloads/debs https://dl.dropboxusercontent.com/u/10808732/tinkerbox-debs.tar.gz
cd ~/downloads/debs/
tar -xf tinkerbox-debs.tar.gz
rm tinkerbox-debs.tar.gz
sudo cp ~/downloads/debs/*.deb /var/local/debs

cd /var/local/debs
dpkg-scanpackages . 2>>~/dpkg-scanpackages.log | gzip -c | sudo tee Packages.gz >/dev/null
cd
sudo apt-get update

sudo apt-get install cb-lock cb-tint2 crunchbang-wallpapers faenza-crunchbang-icon-theme tb-configs tb-exit tb-pipemenus tb-user-setup
# Part II - end


# Part III

# Theming


# need unzip for github, so get all compression utilities first
sudo apt-get install unrar unace unalz unzip lzop rzip zip xz-utils arj bzip2
cd ~/downloads
wget https://github.com/shimmerproject/Greybird/archive/master.zip
unzip -q master.zip
mv Greybird-master Greybird-git
wget http://box-look.org/CONTENT/content-files/154075-Greybird.tar.gz
tar --backup -xf 154075-Greybird.tar.gz
mv Greybird Greybird-ob
sudo cp -r Greybird-{git,ob} /usr/share/themes
cd

session-setup-script=/usr/share/tinkerbox/tb-user-setup

cd /etc/lightdm
sudo mv lightdm.conf lightdm.conf-orig
sed 's|^# *session-setup-script= *$|session-setup-script=/usr/share/tinkerbox/tb-user-setup|' lightdm.conf-orig | sudo tee lightdm.conf >/dev/null
cd

sudo apt-get install iceweasel flashplugin-nonfree gnome-keyring thunar-archive-plugin thunar-media-tags-plugin geany-plugins xfce4-screenshooter xscreensaver
# Part III - end


# Part IV
# Media stuff
sudo apt-get install alsa-base alsa-utils vlc vlc-plugin-notify lame pulseaudio pulseaudio-module-x11 xfce4-mixer xfce4-volumed pavucontrol xfburn volumeicon-alsa

# CLI utilities
sudo apt-get install bash-completion lintian avahi-utils avahi-daemon libnss-mdns gvfs-bin rsync anacron usbutils wmctrl menu bc screen cowsay figlet whois ftp rpl openssh-client sshfs cpufrequtils xtightvncviewer debconf-utils apt-xapian-index build-essential

# GTK utilities 
sudo apt-get install gimp gimp-plugin-registry evince gnumeric galculator gigolo catfish gsimplecal gtrayicon xchat transmission-gtk

# Part IV - end

# Part V
# fortune, wmhacks and welcome -scripts

wget -nd -P ~/downloads/debs http://packages.crunchbang.org/waldorf/pool/main/{cb-fortune_0.01_all.deb,cb-meta-lamp_0.06_all.deb,cb-meta-libreoffice_0.06_all.deb,cb-meta-packaging_0.06_all.deb,cb-meta-printer-support_0.06_all.deb,cb-meta-ssh_0.06_all.deb,cb-meta-vcs_0.06_all.deb,cb-wmhacks_0.06_all.deb}
wget -P ~/downloads/debs https://dl.dropboxusercontent.com/u/10808732/cb-tweaked-debs.tar.gz
cd ~/downloads/debs/
tar -xf cb-tweaked-debs.tar.gz
rm cb-tweaked-debs.tar.gz
sudo cp ~/downloads/debs/*.deb /var/local/debs
cd /var/local/debs
dpkg-scanpackages . 2>>~/dpkg-scanpackages.log | gzip -c | sudo tee Packages.gz >/dev/null
cd
sudo apt-get update
sudo apt-get install cb-fortune cb-wmhacks cb-welcome
# Part V - end


# Finally, start desktop
startx

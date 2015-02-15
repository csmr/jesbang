#!/bin/bash

# Wallyinstall v0.2 - Debian netinstall to #! theme
# - First install debian netinstall - no desktops, only system utilities
# - Download this script to file:
#		$ wget http://koti.kapsi.fi/csmr/jes.sh 
# - enable running it with:
#		$ chmod +x jes.sh
# - go superuser (asks root pass):
#		$ su
# - and run it with:
#		$ ./jes.sh

#Start!
echo "*** Jesbang Wally-modifications install starts! (To install, this script may request root -permissions.)"

# Part I
apt-get update
apt-get upgrade
apt-get -q -y install policykit-1

apt-get -q -y install apt-listbugs

# Generic

# Desktop
apt-get -q -y install xorg
apt-get -q -y install --no-install-recommends openbox obconf thunar e2fsprogs xfsprogs reiserfsprogs reiser4progs jfsutils ntfs-3g fuse gvfs-fuse fusesmb

apt-get -q -y install --no-install-recommends lightdm obmenu thunar-volman desktop-base python-xdg tint2 suckless-tools gmrun nitrogen hsetroot conky-all compton

apt-get -q -y install --no-install-recommends clipit xfce4-power-manager geany lxappearance xfce4-notifyd libnotify-bin gksu synaptic zenity arandr xinput viewnior geeqie scrot vim

apt-get -q -y install --no-install-recommends wireless-tools firmware-linux firmware-iwlwifi firmware-ralink firmware-ipw2x00 firmware-realtek intel-microcode amd64-microcode user-setup ntp curl xsel xdotool htop fbxkb

apt-get -q -y install --no-install-recommends fonts-dejavu fonts-droid ttf-freefont ttf-liberation ttf-mscorefonts-installer gdebi gparted file-roller e2fsprogs xfsprogs reiserfsprogs reiser4progs jfsutils ntfs-3g fuse gvfs-fuse fusesmb dmz-cursor-theme gtk2-engines-murrine gtk2-engines-pixbuf gtk2-engines

# 
apt-get -q -y install sudo terminator network-manager-gnome network-manager-openvpn-gnome network-manager-pptp-gnome network-manager-vpnc-gnome

# sudo style gksu
# make sure gksu runs in sudo mode
update-alternatives --set libgksu-gconf-defaults /usr/share/libgksu/debian/gconf-defaults.libgksu-sudo
update-gconf-defaults
# Part I - end


# Part II
#- Set up local apt-repository
apt-get -q -y install dpkg-dev
mkdir -p /var/local/debs
# local debs
echo "deb file:///var/local/debs ./" > walsrc.list
mv walsrc.list /etc/apt/sources.list.d/debian-wally-sources.list
mkdir -p ~/downloads/debs 
# get packages
wget -nd -P ~/downloads/debs http://packages.crunchbang.org/waldorf/pool/main/{cb-lock_0.01_all.deb,cb-tint2_0.01_all.deb,crunchbang-wallpapers_1.0-1_all.deb,faenza-crunchbang-icon-theme_1.2-crunchang1_all.deb}
wget -P ~/downloads/debs https://dl.dropboxusercontent.com/u/10808732/tinkerbox-debs.tar.gz
cd ~/downloads/debs/
tar -xf tinkerbox-debs.tar.gz
rm tinkerbox-debs.tar.gz
cp ~/downloads/debs/*.deb /var/local/debs

cd /var/local/debs
dpkg-scanpackages . 2>>~/dpkg-scanpackages.log | gzip -c | sudo tee Packages.gz >/dev/null
cd
apt-get update

apt-get -q -y install cb-lock cb-tint2 crunchbang-wallpapers faenza-crunchbang-icon-theme tb-configs tb-exit tb-pipemenus tb-user-setup
# Part II - end


# Part III
# Enable non-free repo - for unrar and flashplayer
echo "deb http://ftp.fi.debian.org/debian jessie contrib non-free" > jesrc.list
mv jesrc.list /etc/apt/sources.list.d/jessie.contrib.nonfree.list # todo

# Theming

# need unzip for github, so get all compression utilities first (from non-free)
apt-get -q -y install unrar unace unalz unzip lzop rzip zip xz-utils arj bzip2
cd ~/downloads
wget https://github.com/shimmerproject/Greybird/archive/master.zip
unzip -q master.zip 
mv Greybird-master Greybird-git
wget http://box-look.org/CONTENT/content-files/154075-Greybird.tar.gz
tar --backup -xf 154075-Greybird.tar.gz
mv Greybird Greybird-ob
cp -r Greybird-{git,ob} /usr/share/themes 
cd

session-setup-script=/usr/share/tinkerbox/tb-user-setup

cd /etc/lightdm
mv lightdm.conf lightdm.conf-orig
sed 's|^# *session-setup-script= *$|session-setup-script=/usr/share/tinkerbox/tb-user-setup|' lightdm.conf-orig | sudo tee lightdm.conf >/dev/null
cd

apt-get -q -y install iceweasel flashplugin-nonfree gnome-keyring thunar-archive-plugin thunar-media-tags-plugin geany-plugins xfce4-screenshooter xscreensaver

# Part III - end


# Part IV
# Media stuff
apt-get -q -y install alsa-base alsa-utils vlc vlc-plugin-notify lame pulseaudio pulseaudio-module-x11 xfce4-mixer xfce4-volumed pavucontrol xfburn volumeicon-alsa

# CLI utilities
apt-get -q -y install bash-completion lintian avahi-utils avahi-daemon libnss-mdns gvfs-bin rsync anacron usbutils wmctrl menu bc screen cowsay figlet whois ftp rpl openssh-client sshfs cpufrequtils xtightvncviewer debconf-utils apt-xapian-index build-essential

# GTK utilities 
apt-get -q -y install gimp gimp-plugin-registry evince gnumeric galculator gigolo catfish gsimplecal gtrayicon xchat transmission-gtk

# Part IV - end

# Part V
# fortune, wmhacks and welcome -scripts

wget -nd -P ~/downloads/debs http://packages.crunchbang.org/waldorf/pool/main/{cb-fortune_0.01_all.deb,cb-meta-lamp_0.06_all.deb,cb-meta-libreoffice_0.06_all.deb,cb-meta-packaging_0.06_all.deb,cb-meta-printer-support_0.06_all.deb,cb-meta-ssh_0.06_all.deb,cb-meta-vcs_0.06_all.deb,cb-wmhacks_0.06_all.deb}
wget -P ~/downloads/debs https://dl.dropboxusercontent.com/u/10808732/cb-tweaked-debs.tar.gz
cd ~/downloads/debs/
tar -xf cb-tweaked-debs.tar.gz
rm cb-tweaked-debs.tar.gz
cp ~/downloads/debs/*.deb /var/local/debs
cd /var/local/debs
dpkg-scanpackages . 2>>~/dpkg-scanpackages.log | gzip -c | sudo tee Packages.gz >/dev/null
cd
apt-get update
apt-get -q -y install cb-fortune cb-wmhacks cb-welcome
# Part V - end

# Make sure we have Virtual Richard Stallman aboard!
apt-get -q -y install vrms
vrms

# Custom
# add users to sudoers, so all users can sudo
echo "%sudo ALL = (ALL) ALL" > sud.tmp
mv sud.tem /etc/sudoers.d/all.users

# Done
echo "*** Jessie Wally-mods done. Restart your computer."


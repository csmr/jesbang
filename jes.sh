#!/bin/bash

jesbang_version="0.3"

# Jesbang - Debian netinstall to #! theme (cousin of the Wally-project by John Raff)
#
# - First install debian netinstall - no desktops, only system utilities
# - Download this script to file:
#		$ wget http://koti.kapsi.fi/csmr/jes.sh
# - enable running it with:
#		$ chmod +x jes.sh
# - go superuser (asks root pass):
#		$ su
# - and run it with:
#		$ ./jes.sh


# log file
log_path="./jes-log.txt"


# additional parameters to pass to apt
apt_get_params=""
debug_flag="n"
bugcheck_flag="y"


set -e # exit immediately on error


# Function to standardize apt-get calls
function apt_get_runner {
    # if any arguments were given, add them to apt-get call
    args="-q -y"
    log "Installing $@" 
    apt-get $args $aptparams install $@ | tee -a $logfile
    log  "Finished Installing $@\n"
    
    if [ "$debug_flag" == "y" ]; then
        read -p "Press [Enter] key to continue...";
    fi
}

# Function to handle logging to the screen and file
function log {
    echo -e "$@" | tee -a $logfile
}

#Help!
function show_help {
    echo 'Jesbang - Cousin of Wally - Cruncbang-linux mods installer $jesbang_version'
		echo "run as root with: $ ./jes.sh [--option [--..]]"
		echo "Options:"
		echo "  --ignore - Do NOT stop on any errors found"
    echo "  --nobugcheck - Do NOT install listbugs to check for known issues"
    echo "  --interactive - Stop and wait for user after each install piece"
    exit 1
}

# Handle command line arguments
while [ "$#" -gt 0 ]; do
	case $1 in
		-h|--help)
			echo "AAAAArhjh '$1'"
			show_help
			exit
			;;
		-i|--ignore)
			echo "*** Jesbang -- Ignoring Errors"
			set +e # ignore errors
			;;
		-b|--nobugcheck)
			echo "*** Jesbang -- Ignoring Bug Checking (not implemented)"
			bugcheck_flag="n"
			;;
		-i|--interactive)
			echo "-- Interactive Mode"
			debug_flag="y"
			;;
		*)
			# unknown option
			;;
	esac
	shift
done


log "*** Jesbang starts! Installing Wally-modifications!"
log "*** You can find logs in '$log_path'"

# Make sure we have elevated privilages, if not exit out
if [ "$(whoami)" != "root" ]; then
	echo "Please restart with elevated privilages by executing with sudo."
	exit 1
fi


log "*** Part I"
#apt-get update
#apt-get upgrade
apt_get_runner policykit-1

if [ "$bugcheck_flag" == "y" ]; then
    echo "***** ALIAS SETUP *****"
    echo alias hld='echo "alias hld = sudo apt-mark hold app_name" ; sudo apt-mark hold' >> ~/.bashrc 
    echo alias unhld='echo "alias unhld = sudo apt-mark unhold app_name" ; sudo apt-mark unhold' >> ~/.bashrc 
    apt_get_runner apt-listbugs
fi

# Generic
# Enable non-free repo - for unrar and flashplayer
log "***** ENABLING NON-FREE REPO *****"
echo "deb http://ftp.ca.debian.org/debian jessie contrib non-free" > jesrc.list
mv jesrc.list /etc/apt/sources.list.d/jessie.contrib.nonfree.list # todo
apt-get update

# Desktop
apt_get_runner xorg
aptparams="--no-install-recommends"
apt_get_runner openbox obconf thunar e2fsprogs xfsprogs reiserfsprogs reiser4progs jfsutils ntfs-3g fuse gvfs-fuse fusesmb

apt_get_runner lightdm obmenu thunar-volman desktop-base python-xdg tint2 suckless-tools gmrun nitrogen hsetroot conky-all compton

apt_get_runner clipit xfce4-power-manager geany lxappearance xfce4-notifyd libnotify-bin gksu synaptic zenity arandr xinput viewnior geeqie scrot vim

apt_get_runner wireless-tools firmware-linux firmware-iwlwifi firmware-ralink firmware-ipw2x00 firmware-realtek intel-microcode amd64-microcode user-setup ntp curl xsel xdotool htop fbxkb

apt_get_runner fonts-dejavu fonts-droid ttf-freefont ttf-liberation ttf-mscorefonts-installer gdebi gparted file-roller e2fsprogs xfsprogs reiserfsprogs reiser4progs jfsutils ntfs-3g fuse gvfs-fuse fusesmb dmz-cursor-theme gtk2-engines-murrine gtk2-engines-pixbuf gtk2-engines

#
aptparams=""
apt_get_runner sudo terminator network-manager-gnome network-manager-openvpn-gnome network-manager-pptp-gnome network-manager-vpnc-gnome

# sudo style gksu
# make sure gksu runs in sudo mode
update-alternatives --set libgksu-gconf-defaults /usr/share/libgksu/debian/gconf-defaults.libgksu-sudo | tee -a $logfile
update-gconf-defaults | tee -a $logfile
# Part I - end


log "***# Part II"
#- Set up local apt-repository
#issues using Tee in here it seems
apt_get_runner dpkg-dev
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
apt-get update 

apt_get_runner cb-lock cb-tint2 crunchbang-wallpapers faenza-crunchbang-icon-theme tb-configs tb-exit tb-pipemenus tb-user-setup
# Part II - end


log "***# Part III"
# Theming

# need unzip for github, so get all compression utilities first (from non-free)
apt_get_runner unrar unace unalz unzip lzop rzip zip xz-utils arj bzip2
cd ~/downloads | tee -a $logfile
wget https://github.com/shimmerproject/Greybird/archive/master.zip | tee -a $logfile
unzip -q master.zip | tee -a $logfilemkdir -p /var/local/debs | tee -a $logfile

mv Greybird-master Greybird-git | tee -a $logfile
wget http://box-look.org/CONTENT/content-files/154075-Greybird.tar.gz | tee -a $logfile
tar --backup -xf 154075-Greybird.tar.gz | tee -a $logfile
mv Greybird Greybird-ob | tee -a $logfile
cp -r Greybird-{git,ob} /usr/share/themes | tee -a $logfile

session-setup-script=/usr/share/tinkerbox/tb-user-setup | tee -a $logfile

cd /etc/lightdm | tee -a $logfile
mv lightdm.conf lightdm.conf-orig | tee -a $logfile
sed 's|^# *session-setup-script= *$|session-setup-script=/usr/share/tinkerbox/tb-user-setup|' lightdm.conf-orig | sudo tee lightdm.conf >/dev/null
cd

apt_get_runner iceweasel flashplugin-nonfree gnome-keyring thunar-archive-plugin thunar-media-tags-plugin geany-plugins xfce4-screenshooter xscreensaver


# Part III - end


log "***# Part IV"
# Media stuff
apt_get_runner alsa-base alsa-utils vlc vlc-plugin-notify lame pulseaudio pulseaudio-module-x11 xfce4-mixer xfce4-volumed pavucontrol xfburn volumeicon-alsa

# CLI utilities
apt_get_runner bash-completion lintian avahi-utils avahi-daemon libnss-mdns gvfs-bin rsync anacron usbutils wmctrl menu bc screen cowsay figlet whois ftp rpl openssh-client sshfs cpufrequtils xtightvncviewer debconf-utils apt-xapian-index build-essential

# GTK utilities
apt_get_runner gimp gimp-plugin-registry evince gnumeric galculator gigolo catfish gsimplecal gtrayicon xchat transmission-gtk

# Part IV - end

log "***# Part V"
# fortune, wmhacks and welcome -scripts
wget -nd -P ~/downloads/debs http://packages.crunchbang.org/waldorf/pool/main/{cb-fortune_0.01_all.deb,cb-meta-lamp_0.06_all.deb,cb-meta-libreoffice_0.06_all.deb,cb-meta-packaging_0.06_all.deb,cb-meta-printer-support_0.06_all.deb,cb-meta-ssh_0.06_all.deb,cb-meta-vcs_0.06_all.deb,cb-wmhacks_0.06_all.deb} 
wget -P ~/downloads/debs https://dl.dropboxusercontent.com/u/10808732/cb-tweaked-debs.tar.gz 
cd ~/downloads/debs/ 
tar -xf cb-tweaked-debs.tar.gz 
rm cb-tweaked-debs.tar.gz 
cp ~/downloads/debs/*.deb /var/local/debs 
cd /var/local/debs 
dpkg-scanpackages . 2>>~/dpkg-scanpackages.log | gzip -c | sudo tee Packages.gz >/dev/null
apt-get update 
apt_get_runner cb-fortune cb-wmhacks cb-welcome
# Part V - end

# Make sure we have Virtual Richard Stallman aboard!
apt_get_runner vrms
vrms | tee -a $logfile

# Custom
# add users to sudoers, so all users can sudo
echo "%sudo ALL = (ALL) ALL" > sud.tmp
mv sud.tmp /etc/sudoers.d/all.users | tee -a $logfile

#games not in roots PATH
/usr/games/cowsay -W20 -e "^^" "Sudoing is now enabled for all users."

# Done
echo "*** Jessie Wally-mods done. Restart your computer."

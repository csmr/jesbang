# JESBANG

Quick and clean way from a headless Debian Jessien -netinstall to a Openbox -base-desktop. Includes minimum of apps, utils and firmware, plus instructions in this readme.

> Note: The current [Debian testing release, Stretch](http://cdimage.debian.org/cdimage/unofficial/non-free/cd-including-firmware/weekly-builds/), seems to work well for me. For a dev-box, I recommend trying this on Stretch instead of Jessie. You get new shiny packages like nvim and rust!

This script was based on John Ruff's #! forum posts. Thanks and Good luck!

## How? 

### I. Install base debian

- Install [Debian Jessie from an image](http://cdimage.debian.org/cdimage/release/current/), with only 'standard system utilities'. No need to install desktop.
- You set the root password, user also.
- Once install finishes and restarts, login as root.

### II. Download and checksum

Use the md5-checksum to ensure the downloaded script is untampered - for a security-check, and peace of mind. On every commit of jes.bang -script into a git-repo, a md5 checksum is calculated of the file 'jes.bang'. 
- In terminal, logged as root (Go as root: `$ su`)
- Install checksum-util, download jesbang and verify the download: 
```shell
apt-get install md5sum
wget -nc https://raw.githubusercontent.com/csmr/jesbang/master/jes.bang
md5sum jes.bang
```

- Compare to [the checksum-file 'md5sum.txt' on Github](http://github.com/csmr/jesbang/blob/master/md5sum.txt)

### III. Run script

- If checksums on github and your terminal are identical, enable running the script, and run it:

```shell
chmod +x jes.bang
./jes.bang
```

Once the script finishes, restart (~20 minutes depending on cpu/network). The login-manager and the desktop are run - login as user, right-click on desktop for app-menu.

### Options
	
 --ignore - Do NOT stop on any errors found

 --bugcheck - Install listbugs to check for known issues

 --interactive - Stop and wait for user after each install piece


- for example, to ignore errors:
	`$ ./jes.bang --ignore`

## Whats it do?

### This script
- installs packages listed in a bash-array with apt-get install (see 'jes.bang')
- writes logs
- tests if install succeeded (only tests couple of packages)
- sets up sudo to use obsolete gksu (pkexec todo - its preferred in debian jessie)
- maybe in future transitions from non-free repo (unrar, mp3 encoder) 
- maybe in future transitions to a Obviux -distro


### The packages
- see 'jes.bang' -file for package lists in `desktop_pack` & `desktop_pack_norecs`.


### The desktop
- Is Openbox + tint2 on Xorg & lightdm -manager.
- right click on empty desktop for app menu
- Vim for editor
- 4 virtual desktops - switch with scroll-up/down on desktop or alt+ctrl+arrow (r/l)
- terminator for terminal: tabs, themes, split panes, jump between pane ctrl+tab


### Things to try after install:

- Play with terminator window

  Right click desktop, select 'Terminal emulator'
  Right click on top bar, select 'Un/decorate'

	- Hide terminator title-bar
	Right click inside terminator window 
	> Preferences > Profile > Show title bar -uncheck

- Firewall on, run gufw in terminal (iptables)
	`$ sudo gufw`
	(asks pass)

- Set network connections
	- Right-click on connections-icon next to clock, select "Edit connections"

- scan the open ports:
  `$ nmap --allports localhost`

- Create a ssh-key
	`$ ssh-keygen`
	(set passphrase)

- browse packages:
	Right-click on empty desktop, from ob-menu select:
	> Debian > Applications > System > Package Management > Synaptic

- customize your Openbox-desktop settings
	`$ iceweasel https://urukrama.wordpress.com/openbox-guide/`

- Read about neovim and linux news
	`$ iceweasel http://neovim.io http://lwn.net`
	
- install a night-sky planetarium -app:
	`$ sudo apt install stellarium`
	and run:
	`$ stellarium &`


### Edit Rust/Ruby/Groovy -code in vim:

- Move to next desktop
	ctrl + alt + right-arrow

- Open terminal: 

	Right click desktop > terminal emulator

	Open vim
	`$ vim parser.ru logic.rb server.groovy`
	:tabnew
	:b2
	:Vex (select with arrow keys + enter)
	:qa

- Get rust - check rustup.rs: 
	`$ www-browser https://rustup.rs`
	('q' quits)

## Help with this
- You can help by testing it. It should work now(TM).
- It should get better package-install tests cover.
- The desktop apps need some mentions in readme.
- It could be made lighter.

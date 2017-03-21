# JESBANG

Sets Debian Jessien netinstaal with Openbox -base-desktop, including minimum of apps, utils and firmware.

Get from a bare desktop-less debian -netinstall to a lightweight openbox desktop quickly. This script was mostly made from John Ruff's #! forum posts. Good luck!

## How? 

- Install Debian Jessie -netinstall with only 'standard system utilities'. 
- Don't install desktop (Gnome, KDE, etc). You may or may not set the root password.
- Once install finishes and restarts, login as root.
- download the script with:

  `$ wget -nc https://raw.githubusercontent.com/csmr/jesbang/master/jes.bang` 
  (original http://csmr.kapsi.fi/blox/jes.bang)


- enable running the script (possibly after md5):

	`$ chmod +x jes.bang`
	

- Run:

	`$ ./jes.bang`


Once the script finishes (~10 minutes depending on download speed), restart.


### Md5 checksum

Every time jes.bang -script is committed, a md5 checksum is calculated to ensure its untampered. You can 'apt-get install md5sum' after downloading the script, run 'md5sum jes.bang' and compare that to the checksum recorded in the github-repo md5sum.txt.


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
- NeoVim for editor
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

- browse & install packages
	`$ sudo synaptic`
		or
	Right-click on empty desktop, from ob-menu select:
	> Debian > Applications > System > Package Management > Synaptic

- Read about neovim and linux news
	`$ iceweasel http://neovim.io http://lwn.net`
	
- install a night-sky planetarium -app:
	`$ sudo apt install stellarium`
	and run:
	`$ stellarium &`


### Edit Rust/Ruby/Groovy -code in Neovim:

- Move to next desktop
	ctrl + alt + right-arrow

- Open terminal: 

	Right click desktop > terminal emulator

	Open neovim
	`$ nvim parser.ru logic.rb server.groovy`
	:tabnew
	:b2
	:Vex (select with arrow keys + enter)
	:qa

- Get rust - check rustup.rs: 
	`$ www-browser https://rustup.rs`
	('q' quits)

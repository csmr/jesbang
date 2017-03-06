## JESBANG

Adds Crunchbang-like desktop to Debian Jessie. Not ready, but might get you a desktop. Good luck!

This is a simple script for automagic Crunchbangification of Debian Jessie netinstall. Makes getting from bare desktop-less debian netinstall to a stylish and lightweight #!-themed openbox desktop quick and painless. This script was mostly made from John Ruff's #! forum posts.

Prerequisite: Install Debian Jessie -netinstall with only standard system utilities. - no desktop (no Gnome, KDE, etc. under "Software selection"). You may or may not set the root password.


- Once install finishes and restarts, login as root.


- download the script with:

  $ wget -nc http://csmr.kapsi.fi/blox/jes.bang

- enable running the script:

	$ chmod +x jes.bang
	

- Run:

	$ ./jes.bang


Once the script finishes (~10 minutes depending on download speed), restart.

### Md5 checksum

Every time jes.bang -script is committed, a md5 checksum is calculated to ensure its untampered. You can 'apt-get install md5sum' after downloading the script, run 'md5sum jes.bang' and compare that to the checksum recorded in the github-repo md5sum.txt.

### Options
	
 --ignore - Do NOT stop on any errors found

 --bugcheck - Install listbugs to check for known issues

 --interactive - Stop and wait for user after each install piece


- for example, to ignore errors:
	$ ./jes.bang --ignore

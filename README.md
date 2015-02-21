# JESBANG

Adds Crunchbang-like desktop to Debian Jessie.

This is a simple script for automagic Crunchbangification of Debian Jessie netinstall. Makes getting from bare desktop-less debian netinstall to a stylish and lightweight #!-themed openbox desktop quick and painless. This script was mostly made from John Ruff's #! forum posts.

- First, install Debian Jessie netinstall with only standard system utilities. - no desktop (no Gnome, KDE, etc. under "Software selection"). You may or may not set the root password.


- Once install finishes and restarts, login as root.


- load the script with:

	$ wget http://koti.kapsi.fi/csmr/jes.sh


- enable running the script:

	$ chmod +x jes.sh
	

- Run:

	$ ./jes.sh


Once the script finishes (~10 minutes depending on download speed), restart.

## Options
	
 --ignore - Do NOT stop on any errors found
 --bugcheck - Install listbugs to check for known issues
 --interactive - Stop and wait for user after each install piece

- for example, to ignore errors:
	$ ./jes.sh --ignore

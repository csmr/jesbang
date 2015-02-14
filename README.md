# JESBANG

A simple script for automating Crunchbang-theming Debian Jessie netinstall. Makes getting from headless, desktop-less debian netinstall to a stylish and lightweight #!-themed openbox desktop quick and painless. This script was mostly made from John Ruff's #! forum posts.


- First, install debian netinstall with only standard system utilities. - no desktop (no Gnome, KDE, etc. under "Software selection"). You may or may not set the root password.


- Once install finishes and restarts, login.


- load the script with:

	$ wget http://koti.kapsi.fi/csmr/jes.sh


- enable running the script:

	$ chmod +x jes.sh


- go superuser (asks root pass):
	
	$ su


- Run:

	$ ./jes.sh


Once the script finishes (3-30 minutes depending on download speed), restart.

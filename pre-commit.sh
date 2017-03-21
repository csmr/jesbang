#!/bin/bash
md5sum jes.bang > md5sum.txt
git add md5sum.txt
scp jes.bang YourLogin@your.host.org:/home/yourlogin/public_html/jes.bang

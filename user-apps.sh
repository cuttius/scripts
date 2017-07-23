#!/bin/sh
# user-apps.sh
# Generates a list of programs that a user installed
# Right now I tested with Ubuntu, but I use FreeBSD also, so I will
# try to update for pkg.

base_app_list=/tmp/baseapps.txt
full_app_list=/tmp/allapps.txt
(gzip -dc /var/log/installer/initial-status.gz | sed -n 's/^Package: //p' | sort -u) >$base_app_list
(apt-mark showmanual | sort -u) >$full_app_list
comm -23 /tmp/allapps.txt /tmp/baseapps.txt

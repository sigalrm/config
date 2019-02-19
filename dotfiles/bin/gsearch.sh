#!/bin/bash

find / \( \
     -path /dev -o \
     -path /home -o \
     -path /media -o \
     -path /mnt -o \
     -path /proc -o \
     -path /run -o \
     -path /sys -o \
     -path /tmp -o \
     -path /var/tmp -o \
     -name lost+found \
     \) -prune -o -iname "$1" -print

#!/bin/bash

cd
gdb .local/share/Steam/steamapps/common/Sid\ Meier\'s\ Civilization\ V/Civ5XP $(ps ux | grep Civ5XP | grep -v grep | awk '{print $2}')

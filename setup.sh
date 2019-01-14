#!/bin/bash

cd
read -p "Are sudo and sshd configured? (y/n) [n] "
if [ "${REPLY:-n}" != y -a "${REPLY:-n}" != Y ]; then exit 9; fi

echo 'Enabling sshd'
sudo systemctl enable sshd.socket sshd.service
sudo systemctl start sshd.socket sshd.service

echo 'Setting up rcm'
ln -sT git/config/dotfiles .dotfiles
ln -sT git/config/dotfiles/rcrc .rcrc

read -p "Install RPMS? (y/n) [y] "
if [ "${REPLY:-y}" = y -o "${REPLY:-y}" = Y ]; then
    sudo dnf -y install $(<git/config/rpms.txt) || exit 1

    read -p "Install termy-devel RPMS? (y/n) [y] "
    if [ "${REPLY:-y}" = y -o "${REPLY:-y}" = Y ]; then
        sudo dnf -y install $(<git/config/rpms-termy.txt) || exit 1
    fi

    echo 'Running rcup'
    rcup

    echo 'Running termy-setup'
    termy-setup --systemd
fi

echo 'Now log out and back in'

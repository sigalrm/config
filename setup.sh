#!/bin/bash

cd
read -p "Are sudo and sshd configured? (y/n) [n] "
if [ "${REPLY:-n}" != y -a "${REPLY:-n}" != Y ]; then exit 9; fi

echo 'Enabling sshd'
sudo systemctl enable sshd.socket sshd.service
sudo systemctl start sshd.socket sshd.service

echo 'Setting up rcm'
ln -sfT git/config/dotfiles .dotfiles
ln -sfT git/config/dotfiles/rcrc .rcrc

echo 'Installing base RPMs'
sudo dnf -y install $(<git/config/rpms.txt) || exit 1

read -p "Install workstation RPMs? (y/n) [y] "
if [ "${REPLY:-y}" = y -o "${REPLY:-y}" = Y ]; then
    sudo dnf install $(<git/config/rpms-ws.txt) || exit 1

    read -p "Install termy-devel RPMs? (y/n) [y] "
    if [ "${REPLY:-y}" = y -o "${REPLY:-y}" = Y ]; then
        sudo dnf install $(<git/config/rpms-termy.txt) || exit 1
    fi
fi

echo 'Running rcup'
rcup

echo 'Running termy-setup'
termy-setup --systemd

echo 'Now log out and back in'

#!/bin/bash
set -x -e -o pipefail


vaultfile=.vault
cmd="ansible-playbook -v --vault-password-file=$vaultfile setup.yaml"
pkgs="git ansible"

pacman-key --init
pacman-key --populate archlinuxarm
pacman -Syu --color=auto --noconfirm
pacman -S --color=auto --noconfirm ${pkgs}

git clone https://github.com/bikochan/c101pa.git
cd c101pa
if [[ ! -f $vaultfile ]]; then
    echo "Ansible's vault password file not found"
    echo "Enter passphrase now to be saved in $vaultfile"
    read vault
    echo -n $vault > $vaultflie
fi

cat <<EOT
If you want to customise, press ctrl-C now then
edit values in the file named 'group_vars/all'
to resume, run: $cmd

otherwise simply pres ENTER to continue with the default values.
EOT
read WAIT
$cmd

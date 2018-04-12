#!/bin/bash
set -x -e -o pipefail

pkgs="git ansible"
pacman -Syu --color=auto
pacman -S --color=auto ${pkgs}

git clone https://bitbucket.org/bikochan/c101pa.git
cd c101pa

cat <<EOT
Edit values in the file named `all` to customise your system
then run:

   ansible-playbook -v setup.yaml

EOT

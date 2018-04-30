#!/bin/bash
set -x -e -o pipefail

pkgs="git ansible"
pacman -Syu --color=auto --noconfirm
pacman -S --color=auto --noconfirm ${pkgs}

# TODO: add a test for vagrant box not to download code
git clone https://bitbucket.org/bikochan/c101pa.git

cat <<EOT
Edit values in the file named `all` to customise your system
then run:

   cd c101pa
   ansible-playbook -v setup.yaml

EOT

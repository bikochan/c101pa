# c101pa setup

These scripts help setting up an ASUS Chromebook c101pa with Arch Linux.
Based on https://archlinuxarm.org/platforms/armv8/rockchip/asus-chromebook-flip-c101pa

After formating the external microSD card to use all available space (all data will be lost,
this will install git + ansible so it can run a playbook to setup the system.

Basic config includes:

- hostname/timezone
- sudo user(s) w/o password!
- some usefull packages: openssh-client, alsa-utils etc

## TODO

Some ideas:

- TEST!
- reduce prompts and other interceptions (automated downloads etc)
- custom disk partitioning
- home/full disk encryption (can it handle it?)
- change root password
- install/configure X and WM


## Installation

After following the steps from https://archlinuxarm.org/platforms/armv8/rockchip/asus-chromebook-flip-c101pa
to enable devloper mode and boot from external storage.

- Download the arch-setup.sh script and execute as root
```
cd /tmp
curl -OL https://bit.ly/2B7hC6F
# aka the long URL below
# curl -OL https://raw.githubusercontent.com/bikochan/c101pa/master/install.sh
bash install.sh
```


## Initial setup

- Reboot into Arch linux but pressing ctrl-u at the splash screen

- login as root using the default password: root)

- Change root password

- Start wifi
```
wifi-menu
```

- Execute the `setup.sh` script as root
```
./setup.sh
```

- Edit the `all` YAML file to customise the system a bit

- Run ansible playbook
```
ansible-playbook -v setup.yaml --vault-password-file=<vault-id-file>
```

## Building vscode

```
pacman -S nodejs npm libsecret python2 gcc make yarn native-keymap
mkdir ~/.npm-global
echo '{}' > package.json

git clone https://github.com/Microsoft/vscode.git
cd vscode
yarn
yarn run watch
```

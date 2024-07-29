#!/usr/bin/env bash

# VARIABLES

TEMP_ROOT="/my-root"
PATH_MAIN_SDX=$1

# METHODS

configureGrub() { \
  echo "Configuring grub..."
  grub-install --target=i386-pc $PATH_MAIN_SDX
  grub-mkconfig -o /boot/grub/grub.cfg
}

configureLanguage() { \
  echo "Configuring languages..."
  echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen
  echo 'LANG=en_US.UTF-8' > /etc/locale.conf
  locale-gen
}

configureTimezone() { \
  echo "Configuring timezone..."
  ln -sf /usr/share/zoneinfo/Europe/Stockholm /etc/localtime
  hwclock --systohc
}

configureNetwork() { \
  echo "Configuring network"
  echo 'arch' > /etc/hostname
  echo -e "127.0.0.1\tlocalhost\n::1\tlocalhost\n127.0.1.1\tarch.localdomain\tarch" > /etc/hosts
}

initramfs() { \
  mkinitcpio -p linux
}

installBaseDevel() { \
  pacman -S base-devel
}

finalize() { \
  echo "Finalizing..."
  exit $?
  umount -R $TEMP_ROOT
  reboot
}

# SCRIPT BEGINS HERE
set -e

configureTimezone
configureLanguage
configureNetwork
initramfs
configureGrub
installBaseDevel
finalize

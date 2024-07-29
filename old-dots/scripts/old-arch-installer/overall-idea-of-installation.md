# WORK IN PROGRESS
Ignore this for now.

# Steps
- Format the hardrive
- Make file systems
- Activate swap (mkswap /dev/SD_WHATEVER amd swapon /dev/SD_WHATEVER)
- Mount partitions
- pacstrap /MOUNT_DIR_ROOT base base-devel vim dialog networkmanager grub wpa_supplicant
- genfstab -U /MOUNT_DIR_ROOT >> /MOUNT_DIR_ROOT/etc/fstab
- arch-chroot /MOUNT_DIR_ROOT
- timedatectl set-ntp true
- systemctl enable NetworkManager
- grub-install --target=i386-pc /dev/SD_WHATEVER
- grub-mkconfig -o /boot/grub/grub.cfg
- password A_PASSWORD
- vim /etc/locale.gen and uncomment the language of preference
- locale-gen
- vim /etc/locale.conf and add the line LANG=en_US.UTF-8
- ln -sf /usr/share/zoneinfo/TIMEZONE_OF_PREFERENCE /etc/localtime
- vim /etc/hostname and add the name of the computer
- exit
- umount -R /MOUNT_DIR_ROOT
- reboot

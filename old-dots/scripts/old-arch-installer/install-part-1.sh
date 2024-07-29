#!/usr/bin/env bash

# VARIABLES

TEMP_ROOT="/my-root"

PATH_BOOT="undefined"
PATH_SWAP="undefined"
PATH_ROOT="undefined"
PATH_HOME="undefined"
PATH_MAIN_SDX="undefined"

PROCEED=false

# METHODS

showHelp() { \
  echo "Provide the path of the following partitions:"
  echo "  -sdx=         : MAIN SDX (sda, sdb, etc) path"
  echo "  -b=|--boot=   : BOOT path"
  echo "  -s=|--swap=   : SWAP path"
  echo "  -r=|--root=   : ROOT path"
  echo "  -h=|--home=   : HOME path"
  echo "  --help        : Print this message"
}

introMessage() { \
  cat << EOL

    =========================================
    Welcome to my ArchLinux installer script!
    =========================================
      In order to proceed you must have previously defined 4 partitions in your hardrive:
      - Root (/)
      - Home (/home)
      - Boot (/boot)
      - Swap

      The script will install and configure the OS for you and it will mostly follow the instructions at
      the ArchLinux wiki (https://wiki.archlinux.org/index.php/installation_guide)

      ARE YOU SURE YOU WOULD LIKE TO PROCEED??? [Y|n]

EOL

  echo -ne "\n"
  read -n 1 PROCEED

  if ! [[ "$PROCEED" =~ Y|y ]]; then
    exit
  fi
}

verifyPath() { \
  if [[ "$1" == "undefined" ]]; then
    echo "The $2 path was not defined. Run the script with --help to see how to define it."
    echo "Exiting the script."
    exit
  fi
}

ensurePaths() { \
  echo "Verifying paths..."
  verifyPath $PATH_BOOT "BOOT"
  verifyPath $PATH_SWAP "SWAP"
  verifyPath $PATH_ROOT "ROOT"
  verifyPath $PATH_HOME "HOME"
  verifyPath $PATH_MAIN_SDX "MAIN SDX"
}

makeFileSystems() { \
  echo "Making file systems..."
  timedatectl set-ntp true
  mkswap $PATH_SWAP
  mkfs.ext4 $PATH_BOOT
  mkfs.ext4 $PATH_ROOT
  mkfs.ext4 $PATH_HOME
}

mountPartitions() {\
  echo "Mounting partitions..."
  mkdir $TEMP_ROOT
  mount $PATH_ROOT $TEMP_ROOT
  mkdir $TEMP_ROOT/boot
  mount $PATH_BOOT $TEMP_ROOT/boot
  mkdir $TEMP_ROOT/home
  mount $PATH_HOME $TEMP_ROOT/home
  swapon $PATH_SWAP
}

installArchBase() { \
  echo "Installing arch base packages"
  pacstrap $TEMP_ROOT base vim dialog grub wpa_supplicant
  genfstab -U $TEMP_ROOT >> $TEMP_ROOT/etc/fstab
}

downloadPart2() {\
  echo "Download second part of the instalation..."
  curl https://raw.githubusercontent.com/thiagokimo/dot-files/master/arch/install-part-2.sh --output $TEMP_ROOT/install-part-2.sh
}

executeInstallationPart2() {\
  chmod +x $TEMP_ROOT/install-part-2.sh
  arch-chroot $TEMP_ROOT ./install-part-2.sh $PATH_MAIN_SDX
}

# PARAMS

for i in "$@"
do
  case $i in
    -b=*|--boot=*)
    PATH_BOOT="${i#*=}"
    shift
    ;;
    -s=*|--swap=*)
    PATH_SWAP="${i#*=}"
    shift
    ;;
    -r=*|--root=*)
    PATH_ROOT="${i#*=}"
    shift
    ;;
    -h=*|--home=*)
    PATH_HOME="${i#*=}"
    shift
    ;;
    -sdx=*|--sdx=*)
    PATH_MAIN_SDX="${i#*=}"
    shift
    ;;
    --help )
    showHelp && exit
    ;;
  esac
done

# SCRIPT BEGINS HERE
set -e

introMessage
ensurePaths
makeFileSystems
mountPartitions
installArchBase
downloadPart2
executeInstallationPart2

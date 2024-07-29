#!/usr/bin/env bash

PATH_HOME=""
PROCEED=n:
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

showHelp() { \
  echo "Usage:"
  echo "  --home-folder     : Path of your home folder"
  echo "  --help            : Print this message"
}

introMessage() { \
  cat << EOL
  ========================================
  Welcome to my dotfiles installer script!
  ========================================
  This script will replace some of the directories and files inside the $PATH_HOME directory.
EOL

  echo -ne "\n"
  read -p "Would you like to proceed? [Y|n]" PROCEED

  if ! [[ "$PROCEED" =~ Y|y ]]; then
    echo "Exiting\n"
    exit
  fi 
}

# # # # # # # # # # # # 
#
# verifyArgs
#
# Make sure that PATH_HOME is provided to the script. Exit otherwise
#
# # # # # # # # # # # #
verifyArgs() { \
  if [ -z "$PATH_HOME" ]; then
    echo "The home folder path was not defined. Run the script with --help for more information."
    echo "Exiting"
    exit
  fi
}

ensureConfigFolder() { \
  if ! [ -d "$PATH_HOME/.config" ]; then
    echo "Config folder doesn't exist. Creating it..."
    mkdir $PATH_HOME/.config
  fi
}

# # # # # # # # # # # # #
#
# symlinkContent 
#
# This function verifies if the location you intent to create a symlink already contains content.
# Whenever that is the case, the function will ask if you would like to skip the symlinking or replace it.
# 
# params:
#
# $1 - name of what the thing is (just used to display what is happening)
# $2 - source (path)
# $3 - symlink destination (path)
# 
#
# # # # # # # # # # # # #
symlinkContent() { \
  echo "Begin symlinking of $1..."
  if [ -d "$PATH_HOME/$3" ] || [ -f $PATH_HOME/$3 ]; then
    echo "The dots your want to install already exist. Replace? [Y|n]" && read confirm_replace
    
     if ! [[ "$confirm_replace" =~ Y|y ]]; then
      echo "Skipping $1..."
    else
      echo "Replacing dots..."
      rm -rf $3
      ln -sf $2 $3
    fi
  else
    echo "Creating $1 symlinks..."
    ln -sf $2 $3
  fi
}

makeDotsExecutable() { \
  echo "Making a few dots executable..."
  chmod 755 $SCRIPT_DIR/config/bspwm/bspwmrc $SCRIPT_DIR/config/sxhkd/sxhkdrc && echo ""
}

symlinkStuff() { \
  # dots in the home root
  ln -sf $SCRIPT_DIR/profile .profile
  ln -sf $SCRIPT_DIR/path .path
  ln -sf $SCRIPT_DIR/zshrc .zshrc
  ln -sf $SCRIPT_DIR/xinitrc .xinitrc
  ln -sf $SCRIPT_DIR/vimrc .vimrc
  
  # symlinkContent "PROFILE" "$SCRIPT_DIR/profile" "$PATH_HOME/.profile" ".profile" 
  # symlinkContent "PATH" "$SCRIPT_DIR/path" "$PATH_HOME/.path" ".path"
  # symlinkContent "ZSHRC" "$SCRIPT_DIR/zshrc" "$PATH_HOME/.zshrc" ".zshrc"
  # symlinkContent "XINITRC" "$SCRIPT_DIR/xinitrc" "$PATH_HOME/.xinitrc" ".xinitrc"
  # symlinkContent "VIMRC" "$SCRIPT_DIR/vimrc" "$PATH_HOME/.vimrc" ".vimrc"
  
  # things from the .config folder
  ln -sf $SCRIPT_DIR/config/bspwm/ $PATH_HOME/.config/
  ln -sf $SCRIPT_DIR/config/sxhkd/ $PATH_HOME/.config/
  ln -sf $SCRIPT_DIR/config/picom/ $PATH_HOME/.config/
  ln -sf $SCRIPT_DIR/config/alactritty/ $PATH_HOME/.config/
  ln -sf $SCRIPT_DIR/config/polybar/ $PATH_HOME/.config/  

  # symlinkContent "BSPWM" "$SCRIPT_DIR/config/bspwm" "$PATH_HOME/.config/" "bspwm" 
  # symlinkContent "SXHKD" "$SCRIPT_DIR/config/sxhkd" "$PATH_HOME/.config/" "sxhkd"
  
  # other folders (not necessarily hidden)
  ln -sf $SCRIPT_DIR/screenlayout $PATH_HOME/.screenlayout
  ln -sf $SCRIPT_DIR/.bin $PATH_HOME/.bin
  ln -sf $SCRIPT_DIR/wallpapers $PATH_HOME/wallpapers
  ln -sf $SCRIPT_DIR/keebs $PATH_HOME/keebs
  ln -sf $SCRIPT_DIR/scripts $PATH_HOME/scripts

  # symlinkContent "SCREEN LAYOUTS" "$SCRIPT_DIR/.screenlayout" "$PATH_HOME/" ".screenlayout"
  # symlinkContent "SHORTCUTS" "$SCRIPT_DIR/.bin" "$PATH_HOME/" ".bin"
  # symlinkContent "WALLPAPERS" "$SCRIPT_DIR/wallpapers" "$PATH_HOME/" "wallpapers"
  # symlinkContent "KEYBOARD KEYMAPS" "$SCRIPT_DIR/keebs" "$PATH_HOME/" "keebs"
  # symlinkContent "SCRIPTS" "$SCRIPT_DIR/scripts" "$PATH_HOME/" "scripts"
 
  sleep 1
  echo ""
  
  # Uncomment this and try it in a blank folder to see the final results
  # echo "The final content of the $PATH_HOME folder is the following:"
  # ls -aLR $PATH_HOME/
}



# PARSE PARAMS
for i in "$@"; do
  case $i in 
    --home-folder=*)
    PATH_HOME="${i#*=}" 
    shift
    ;;
    --help )
    showHelp && exit
  esac
done

# BEGINS HERE
set -e

verifyArgs
introMessage
ensureConfigFolder
makeDotsExecutable
symlinkStuff


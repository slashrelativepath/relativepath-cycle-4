#!/bin/bash

# shell script to install homebrew

# check operating system
if [ "$(uname)" = 'Darwin' ]
then
  
  echo "checking if brew is installed"  
  if (which brew)                   
  then 
    echo "brew is installed"
  else
    echo "installing brew"
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  echo "checking if nano is installed"
  if (which nano)
  then 
    echo "nano is already installed"
  else
    echo "installing nano"
    brew install nano
  fi

  echo "checking if git is installed"
  if (which git)
  then
    echo "git is already installed"
  else
    echo "installing git"
    brew install git
  fi

  echo  "checking if multipass installed"
  if (which multipass) 
  then 
    echo "multipass already installed" 
  else
    echo "installing multipass"
    brew install --cask multipass
  fi
 
else
  echo "This script is only for Mac. You are using $(uname). Please run the script for $(uname)."
fi

if [ -f ./id_ed25519 ] 
then
  echo "ssh key pair already exists"
else
  echo "creating ssh key pair" 
  ssh-keygen -t ed25519 -f "./id_ed25519" -N ''
fi

echo "launching multipass vm"
multipass launch --name relativepath

ssh -i ./id_ed25519 ubuntu@192.168.64.17


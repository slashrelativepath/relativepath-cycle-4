#!/bin/bash

# shell script to install homebrew

echo "checking if brew is installed"

# check operating system

if (which brew)                   
then 
  echo "brew is installed"
else
  echo "installing brew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
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

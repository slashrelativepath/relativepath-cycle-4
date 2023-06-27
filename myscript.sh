x#!/bin/zsh

# shell script to install homebrew

echo "checking if brew is installed"

if (which brew)                   
then 
  echo "brew is installed"
else
  echo "installing brew"
  /bin/bash -c "$(curl -fsSL 
https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# checking if nano is installed
# if nano installed
# then echo "nano is already installed"


#!/bin/bash

# Install Homebrew
if ( which brew > /dev/null )
then 
  echo -e "\n==== Brew installed ====\n"
else
  echo -e "\n==== Installing brew ====\n"
  sudo true; NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install Nano
if ( which brew > /dev/null )
then 
  echo -e "\n==== Nano installed ====\n"
else
  echo -e "\n==== Installing Nano ====\n"
  brew install nano
fi

# Install Git
if ( which git > /dev/null )
then 
  echo -e "\n==== Git installed ====\n"
else
  echo -e "\n==== Installing Git ====\n"
  brew install git
fi

# Install Multipass
if ( which multipass > /dev/null )
then 
  echo -e "\n==== Multipass installed ====\n"
else
  echo -e "\n==== Installing Multipass ====\n"
  brew install --cask multipass
fi

# Set Multipass local driver to Qemu
if [ "$(multipass get local.driver)" = "qemu" ]
then
  echo -e -e "\n==== Qemu local driver set ====\n"
else
  echo -e -e "\n==== Setting Qemu as Multipass local driver ====\n"
  multipass set local.driver=qemu
fi
 
# Create SSH keys
if [ -f id_ed25519 ]
then 
  echo -e "\n==== SSH keys present ====\n"
else
  echo -e "\n==== Creating SSH keys ====\n"
  ssh-keygen -t ed25519 -f "id_ed25519" -N ''
fi

# Create cloud-init.yaml
if [ -f cloud-init.yaml ] 
then
  echo -e "\n==== Cloud-init.yaml present ====\n"
else
  echo -e "\n==== Creating cloud-init.yaml ====\n"
  cat <<- EOF > cloud-init.yaml
users:
  - default
  - name: $USER
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
    ssh_authorized_keys:
      - $(cat id_ed25519.pub)
EOF
fi

# Launch Relativepath instance
if ( multipass list | grep relativepath | grep Running > /dev/null )
then 
  echo -e "\n==== Relativepath VM present ====\n"
else 
  echo -e "\n==== Creating Relativepath VM ====\n"
  multipass launch --name relativepath --cloud-init cloud-init.yaml
fi

# SSH into Relativepath VM
ssh -o StrictHostKeyChecking=no -i "./id_ed25519" $USER@$(multipass info relativepath | grep IPv4 | awk '{ print $2 }')



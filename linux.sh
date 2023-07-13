if (which multipass)
then
  echo "multipass already install"
else
  sudo snap install multipass
fi

echo "lauching relativepath vm" 
multipass launch --name relativepath


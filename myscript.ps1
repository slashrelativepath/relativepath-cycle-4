# powershell script to install chocolatey 

echo "checking if chocolatey installed"
if (get-command choco)
{
echo "chocholatey is already installed"
}
else
{
echo "installing chocolatey" 
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}

echo "checking if nano is installed"
if (get-command nano)
{
echo "nano is already installed" 
}
else
{
echo "installing nano" 
choco install nano
}

echo "checking if git is installed"
if (get-command git)
{
echo "git is already installed" 
}
else
{
echo "installing git" 
choco install git
}

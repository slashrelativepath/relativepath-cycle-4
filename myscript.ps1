# build a local web server  

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
choco install git.install -y --params "'/GitAndUnixToolsOnPath /WindowsTerminal /NoAutoCrlf'"
}

echo "installing multipass hypervisor"
if (get-command multipass)
{
echo "multipass already installed" 
} 
else 
{
echo "installing multipass" 
choco install multipass
}

#Refresh Environment
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + 
[System.Environment]::GetEnvironmentVariable("Path","User")
refreshenv
Import-Module "$env:ProgramData\chocolatey\helpers\chocolateyInstaller.psm1"; Update-SessionEnvironment

#!/bin/bash
userName=ubuntu
homeFolder=/home/$userName
sudo apt update -y 
wget https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt-get update -y
sudo apt-get install -y apt-transport-https 
sudo apt-get update -y
sudo apt-get install -y dotnet-sdk-3.1

sudo apt-get install nginx -y

echo "switch user to ubuntu"
su - ubuntu
echo "current directory"
echo $PWD
echo "create engaze directory"
echo $homeFolder
mkdir $homeFolder/engaze
cd $homeFolder/engaze
mkdir git
cd git
echo "Change to git directory"
echo $PWD
echo "Checkout Infra"
git clone https://github.com/redtopdev/Infra.git
cd Infra
git checkout -b "BootStrap" origin/BootStrap
echo "Setting permission to run buildAndPublishAllServices.sh"
chmod 777 ./Deployment/BuildScriptsAutoV2/buildAndPublishAllServices.sh
echo "Creating and setting owvership to /home/.dotnet folder"
mkdir $homeFolder/.dotnet
echo "Set environment variable"
export DOTNET_CLI_HOME=$homeFolder/.dotnet
echo $DOTNET_CLI_HOME
chown -R ubuntu: $homeFolder/.dotnet
echo "Setting ownership to /home/ubuntu/engaze folder"
chown -R ubuntu: $homeFolder/engaze/
echo "Running BuildAndPublishAllServices.sh"
./Deployment/BuildScriptsAutoV2/buildAndPublishAllServices.sh $userName

sudo cp $homeFolder/engaze/git/Infra/Deployment/BuildScriptsAutoV2/nginx-sitesenabled-default /etc/nginx/sites-enabled/default
systemctl restart nginx

#ps aux | grep dotnet
#kill -9 14470
#/home/ubuntu/engaze/git/Infra/Deployment/BuildScriptsAutoV2/buildAndPublishAllServices.sh
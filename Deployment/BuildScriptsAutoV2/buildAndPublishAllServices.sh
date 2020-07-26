#!/bin/bash
echo "Setting permissions to build scripts"
chmod 777 /home/$1/engaze/git/Infra/Deployment/BuildScriptsAutoV2/build-publish-api-event.sh
chmod 777 /home/$1/engaze/git/Infra/Deployment/BuildScriptsAutoV2/build-publish-api-managesubscriber.sh

echo ">>>>>>>>>>>>Build & Publish EventAPI"
/home/$1/engaze/git/Infra/Deployment/BuildScriptsAutoV2/build-publish-api-event.sh $1 
echo ">>>>>>>>>>>>Build & Publish Managesubscriber"
/home/$1/engaze/git/Infra/Deployment/BuildScriptsAutoV2/build-publish-api-managesubscriber.sh $1

echo "Running API EventAPI.Service.dll"
cd /home/$1/engaze/api/event/
dotnet Engaze.Event.Service.dll --console &
echo "Running API SubScriber.Service.dll"
cd /home/$1/engaze/api/managesubscriber
dotnet Subscriber.Service.dll --console &
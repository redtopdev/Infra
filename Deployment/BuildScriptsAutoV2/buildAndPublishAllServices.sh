#!/bin/bash
echo "Setting permissions to build scripts"
chmod 777 /home/$1/engaze/git/Infra/Deployment/BuildScriptsAutoV2/build-publish-api-event.sh
chmod 777 /home/$1/engaze/git/Infra/Deployment/BuildScriptsAutoV2/build-publish-api-managesubscriber.sh
chmod 777 /home/$1/engaze/git/Infra/Deployment/BuildScriptsAutoV2/build-publish-api-location.sh
chmod 777 /home/$1/engaze/git/Infra/Deployment/BuildScriptsAutoV2/build-publish-api-pushnotification.sh

echo ">>>>>>>>>>>>Build & Publish EventAPI"
/home/$1/engaze/git/Infra/Deployment/BuildScriptsAutoV2/build-publish-api-event.sh $1 
echo ">>>>>>>>>>>>Build & Publish Managesubscriber"
/home/$1/engaze/git/Infra/Deployment/BuildScriptsAutoV2/build-publish-api-managesubscriber.sh $1
echo ">>>>>>>>>>>>Build & Publish Location API"
/home/$1/engaze/git/Infra/Deployment/BuildScriptsAutoV2/build-publish-api-location.sh $1
echo ">>>>>>>>>>>>Build & Publish PushNotification API"
/home/$1/engaze/git/Infra/Deployment/BuildScriptsAutoV2/build-publish-api-pushnotification.sh $1

echo "Running API EventAPI.Service.dll"
cd /home/$1/engaze/api/event/
dotnet Engaze.Event.Service.dll --console &
echo "Running API SubScriber.Service.dll"
cd /home/$1/engaze/api/managesubscriber
dotnet Subscriber.Service.dll --console &
echo "Running API ShareLocation.Service.dll"
cd /home/$1/engaze/api/location
dotnet ShareLocation.Service.dll --console &
echo "Running API Notification.Service.dll"
cd /home/$1/engaze/api/pushnotification
dotnet Notification.Service.dll --console &
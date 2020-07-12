#!/bin/bash

chmod 777 /home/$1/engaze/git/Infra/Deployment/BuildScriptsAuto/build-publish-api-eventquery.sh
chmod 777 /home/$1/engaze/git/Infra/Deployment/BuildScriptsAuto/build-publish-api-managesubscriber.sh
chmod 777 /home/$1/engaze/git/Infra/Deployment/BuildScriptsAuto/build-publish-api-eventowrite.sh
chmod 777 /home/$1/engaze/git/Infra/Deployment/BuildScriptsAuto/build-publish-svc-eventoviewdataupdater.sh 
chmod 777 /home/$1/engaze/git/Infra/Deployment/BuildScriptsAuto/build-publish-svc-eventsubscriber.sh

/home/$1/engaze/git/Infra/Deployment/BuildScriptsAuto/build-publish-api-eventquery.sh $1 
/home/$1/engaze/git/Infra/Deployment/BuildScriptsAuto/build-publish-api-managesubscriber.sh $1
/home/$1/engaze/git/Infra/Deployment/BuildScriptsAuto/build-publish-api-eventowrite.sh $1
/home/$1/engaze/git/Infra/Deployment/BuildScriptsAuto/build-publish-svc-eventoviewdataupdater.sh $1  
/home/$1/engaze/git/Infra/Deployment/BuildScriptsAuto/build-publish-svc-eventsubscriber.sh $1

echo "Running API EventQuery.Service.dll"
cd /home/$1/engaze/api/eventquery/
dotnet EventQuery.Service.dll --console &
echo "Running API SubScriber.Service.dll"
cd /home/$1/engaze/api/managesubscriber
dotnet Subscriber.Service.dll --console &
echo "Running API Evento.Service.dll"
cd /home/$1/engaze/api/eventowrite
dotnet Evento.Service.dll --console &
echo "Running SVC Engaze.Evento.ViewDataUpdater.Service.dll"
cd /home/$1/engaze/svc/eventoviewdataupdater
dotnet Engaze.Evento.ViewDataUpdater.Service.dll --console &
echo "Running SVC Engaze.EventSubscriber.Service.dll"
cd /home/$1/engaze/svc/eventsubscriber
dotnet Engaze.EventSubscriber.Service.dll --console &
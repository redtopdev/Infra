
chmod 700 ~/engaze/git/Infra/Deployment/BuildScriptsAuto/build-publish-api-eventquery.sh
chmod 700 ~/engaze/git/Infra/Deployment/BuildScriptsAuto/build-publish-api-managesubscriber.sh
chmod 700 ~/engaze/git/Infra/Deployment/BuildScriptsAuto/build-publish-api-eventowrite.sh
chmod 700 ~/engaze/git/Infra/Deployment/BuildScriptsAuto/build-publish-svc-eventoviewdataupdater.sh 
chmod 700 ~/engaze/git/Infra/Deployment/BuildScriptsAuto/build-publish-svc-eventsubscriber.sh

~/engaze/git/Infra/Deployment/BuildScriptsAuto/build-publish-api-eventquery.sh  
~/engaze/git/Infra/Deployment/BuildScriptsAuto/build-publish-api-managesubscriber.sh
~/engaze/git/Infra/Deployment/BuildScriptsAuto/build-publish-api-eventowrite.sh
~/engaze/git/Infra/Deployment/BuildScriptsAuto/build-publish-svc-eventoviewdataupdater.sh  
~/engaze/git/Infra/Deployment/BuildScriptsAuto/build-publish-svc-eventsubscriber.sh

echo "Running API EventQuery.Service.dll"
cd ~/engaze/api/eventquery/
dotnet EventQuery.Service.dll --console &
echo "Running API SubScriber.Service.dll"
cd ~/engaze/api/managesubscriber
dotnet Subscriber.Service.dll --console &
echo "Running API Evento.Service.dll"
cd ~/engaze/api/eventowrite
dotnet Evento.Service.dll --console &
echo "Running SVC Engaze.Evento.ViewDataUpdater.Service.dll"
cd ~/engaze/svc/eventoviewdataupdater
dotnet Engaze.Evento.ViewDataUpdater.Service.dll --console &
echo "Running SVC Engaze.EventSubscriber.Service.dll"
cd ~/engaze/svc/eventsubscriber
dotnet Engaze.EventSubscriber.Service.dll --console &
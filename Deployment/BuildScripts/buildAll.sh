
chmod 700 ./build-scripts/build-publish-api-eventquery.sh
chmod 700 ./build-scripts/build-publish-api-managesubscriber.sh
chmod 700 ./build-scripts/build-publish-api-eventowrite.sh
chmod 700 ./build-scripts/build-publish-svc-eventoviewdataupdater.sh 
chmod 700 ./build-scripts/build-publish-svc-eventsubscriber.sh

./build-scripts/build-publish-api-eventquery.sh  
./build-scripts/build-publish-api-managesubscriber.sh
./build-scripts/build-publish-api-eventowrite.sh
./build-scripts/build-publish-svc-eventoviewdataupdater.sh  
./build-scripts/build-publish-svc-eventsubscriber.sh

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

DIR=/home/$1/engaze/git/
if [ -d $DIR ]; then
  # Take action if $DIR exists. #
  echo "git folder exists"
else
  ###  Control will jump here if $DIR does NOT exists ###
  echo "Folder  ${DIR} not found. Creating the same."
  #mkdir /home/$1/engaze/git/
fi

cd /home/$1/engaze/git
DIR=/home/$1/engaze/git/EventoViewDataUpdater/
if [ -d $DIR ]; then
  # Take action if $DIR exists. #
  echo "Cleaning up /home/$1/engaze/git/EventoViewDataUpdater folder before cloning."
  rm -r -f /home/$1/engaze/git/EventoViewDataUpdater/
else
  ###  Control will jump here if $DIR does NOT exists ###
  echo "${DIR} not found."
  
fi


echo "stopping Engaze.Evento.ViewDataUpdater.Service.dll"
kill -9 $(ps aux | grep 'Engaze.Evento.ViewDataUpdater.Service.dll' | awk '{print $2}')

echo "Cloning https://github.com/redtopdev/EventoViewDataUpdater.git"
git clone https://github.com/redtopdev/EventoViewDataUpdater.git
echo "Building /home/$1/engaze/git/EventoViewDataUpdater/EventoViewDataUpdater.sln"
dotnet build --configuration debug /home/$1/engaze/git/EventoViewDataUpdater/EventoViewDataUpdater.sln
echo "Publishing /home/$1/engaze/git/EventoViewDataUpdater/EventoReadDataUpdater/Engaze.Evento.ViewDataUpdater.Service.csproj to /home/$1/engaze/svc/eventoviewdataupdater/  folder."
dotnet publish --output /home/$1/engaze/svc/eventoviewdataupdater/ /home/$1/engaze/git/EventoViewDataUpdater/EventoReadDataUpdater/Engaze.Evento.ViewDataUpdater.Service.csproj
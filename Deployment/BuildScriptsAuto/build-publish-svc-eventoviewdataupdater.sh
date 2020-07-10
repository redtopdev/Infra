DIR=~/engaze/git/
if [ -d $DIR ]; then
  # Take action if $DIR exists. #
  echo "git folder exists"
else
  ###  Control will jump here if $DIR does NOT exists ###
  echo "Folder  ${DIR} not found. Creating the same."
  #mkdir ~/engaze/git/
fi

cd ~/engaze/git
DIR=~/engaze/git/EventoViewDataUpdater/
if [ -d $DIR ]; then
  # Take action if $DIR exists. #
  echo "Cleaning up ~/engaze/git/EventoViewDataUpdater folder before cloning."
  rm -r -f ~/engaze/git/EventoViewDataUpdater/
else
  ###  Control will jump here if $DIR does NOT exists ###
  echo "${DIR} not found."
  
fi


echo "stopping Engaze.Evento.ViewDataUpdater.Service.dll"
kill -9 $(ps aux | grep 'Engaze.Evento.ViewDataUpdater.Service.dll' | awk '{print $2}')

echo "Cloning https://github.com/redtopdev/EventoViewDataUpdater.git"
git clone https://github.com/redtopdev/EventoViewDataUpdater.git
echo "Building ~/engaze/git/EventoViewDataUpdater/EventoViewDataUpdater.sln"
dotnet build --configuration debug ~/engaze/git/EventoViewDataUpdater/EventoViewDataUpdater.sln
echo "Publishing ~/engaze/git/EventoViewDataUpdater/EventoReadDataUpdater/Engaze.Evento.ViewDataUpdater.Service.csproj to ~/engaze/svc/eventoviewdataupdater/  folder."
dotnet publish --output ~/engaze/svc/eventoviewdataupdater/ ~/engaze/git/EventoViewDataUpdater/EventoReadDataUpdater/Engaze.Evento.ViewDataUpdater.Service.csproj
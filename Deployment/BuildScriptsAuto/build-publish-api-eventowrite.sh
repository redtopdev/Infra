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
DIR=~/engaze/git/EventoWriteAPI/
if [ -d $DIR ]; then
  # Take action if $DIR exists. #
  echo "Cleaning up ~/engaze/git/EventoWriteAPI folder before cloning."
  rm -r -f ~/engaze/git/EventoWriteAPI/
else
  ###  Control will jump here if $DIR does NOT exists ###
  echo "${DIR} not found."
  
fi


echo "stopping Evento.Service"
kill $(ps aux | grep 'Evento.Service.dll' | awk '{print $2}')

echo "Cloning https://github.com/redtopdev/EventoWriteAPI.git"
git clone https://github.com/redtopdev/EventoWriteAPI.git
echo "Building ~/engaze/git/EventoWriteAPI/Evento.sln"
dotnet build --configuration debug ~/engaze/git/EventoWriteAPI/Evento.sln
echo "Publishing ~/engaze/git/EventoWriteAPI/API/Evento.csproj to ~/engaze/api/eventowrite/  folder."
dotnet publish --output ~/engaze/api/eventowrite/ ~/engaze/git/EventoWriteAPI/API/Evento.csproj
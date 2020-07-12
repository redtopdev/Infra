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
DIR=/home/$1/engaze/git/EventoWriteAPI/
if [ -d $DIR ]; then
  # Take action if $DIR exists. #
  echo "Cleaning up /home/$1/engaze/git/EventoWriteAPI folder before cloning."
  rm -r -f /home/$1/engaze/git/EventoWriteAPI/
else
  ###  Control will jump here if $DIR does NOT exists ###
  echo "${DIR} not found."
  
fi


echo "stopping Evento.Service"
kill $(ps aux | grep 'Evento.Service.dll' | awk '{print $2}')

echo "Cloning https://github.com/redtopdev/EventoWriteAPI.git"
git clone https://github.com/redtopdev/EventoWriteAPI.git
echo "Building /home/$1/engaze/git/EventoWriteAPI/Evento.sln"
dotnet build --configuration debug /home/$1/engaze/git/EventoWriteAPI/Evento.sln
echo "Publishing /home/$1/engaze/git/EventoWriteAPI/API/Evento.csproj to /home/$1/engaze/api/eventowrite/  folder."
dotnet publish --output /home/$1/engaze/api/eventowrite/ /home/$1/engaze/git/EventoWriteAPI/API/Evento.csproj
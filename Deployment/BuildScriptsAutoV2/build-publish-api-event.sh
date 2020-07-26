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
DIR=/home/$1/engaze/git/Event/
if [ -d $DIR ]; then
  # Take action if $DIR exists. #
  echo "Cleaning up /home/$1/engaze/git/Event folder before cloning."
  rm -r -f /home/$1/engaze/git/Event/
else
  ###  Control will jump here if $DIR does NOT exists ###
  echo "${DIR} not found."
  
fi

echo "stopping EventQuery.Service.dll"
kill $(ps aux | grep 'Engaze.Event.Service.dll' | awk '{print $2}')

echo "Cloning https://github.com/redtopdev/Event.git"
git clone https://github.com/redtopdev/Event.git
echo "Building /home/$1/engaze/git/Event/Evento.sln"
dotnet build --configuration debug /home/$1/engaze/git/Event/Evento.sln
echo "Publishing /home/$1/engaze/git/Event/API/Evento.csproj to /home/$1/engaze/api/event/  folder."
dotnet publish --output /home/$1/engaze/api/event/ /home/$1/engaze/git/Event/API/Evento.csproj
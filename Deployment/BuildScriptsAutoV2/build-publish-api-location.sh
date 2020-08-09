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
DIR=/home/$1/engaze/git/LocationShare/
if [ -d $DIR ]; then
  # Take action if $DIR exists. #
  echo "Cleaning up /home/$1/engaze/git/LocationShare folder before cloning."
  rm -r -f /home/$1/engaze/git/LocationShare/
else
  ###  Control will jump here if $DIR does NOT exists ###
  echo "${DIR} not found."
  
fi


echo "stopping ShareLocation.Service.dll"
kill $(ps aux | grep 'ShareLocation.Service.dll' | awk '{print $2}')

echo "Cloning https://github.com/redtopdev/LocationShare.git"
git clone https://github.com/redtopdev/LocationShare.git
echo "Building /home/$1/engaze/git/LocationShare/LocationShare.sln"
dotnet build --configuration debug /home/$1/engaze/git/LocationShare/LocationShare.sln
echo "Publishing /home/$1/engaze/git/LocationShare/Service/ShareLocation.csproj to /home/$1/engaze/api/location/  folder."
dotnet publish --output /home/$1/engaze/api/location/ /home/$1/engaze/git/LocationShare/Service/ShareLocation.csproj
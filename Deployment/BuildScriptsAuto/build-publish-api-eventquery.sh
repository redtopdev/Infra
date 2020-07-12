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
DIR=/home/$1/engaze/git/EventQuery/
if [ -d $DIR ]; then
  # Take action if $DIR exists. #
  echo "Cleaning up /home/$1/engaze/git/EventQuery folder before cloning."
  rm -r -f /home/$1/engaze/git/EventQuery/
else
  ###  Control will jump here if $DIR does NOT exists ###
  echo "${DIR} not found."
  
fi

echo "stopping EventQuery.Service.dll"
kill $(ps aux | grep 'EventQuery.Service.dll' | awk '{print $2}')

echo "Cloning https://github.com/redtopdev/EventQuery.git"
git clone https://github.com/redtopdev/EventQuery.git
echo "Building /home/$1/engaze/git/EventQuery/EventQuery.sln"
dotnet build --configuration debug /home/$1/engaze/git/EventQuery/EventQuery.sln
echo "Publishing /home/$1/engaze/git/EventQuery/Service/EventQuery.csproj to /home/$1/engaze/api/eventquery/  folder."
dotnet publish --output /home/$1/engaze/api/eventquery/ /home/$1/engaze/git/EventQuery/Service/EventQuery.csproj
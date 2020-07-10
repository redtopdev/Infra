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
DIR=~/engaze/git/EventQuery/
if [ -d $DIR ]; then
  # Take action if $DIR exists. #
  echo "Cleaning up ~/engaze/git/EventQuery folder before cloning."
  rm -r -f ~/engaze/git/EventQuery/
else
  ###  Control will jump here if $DIR does NOT exists ###
  echo "${DIR} not found."
  
fi

echo "stopping EventQuery.Service.dll"
kill $(ps aux | grep 'EventQuery.Service.dll' | awk '{print $2}')

echo "Cloning https://github.com/redtopdev/EventQuery.git"
git clone https://github.com/redtopdev/EventQuery.git
echo "Building ~/engaze/git/EventQuery/EventQuery.sln"
dotnet build --configuration debug ~/engaze/git/EventQuery/EventQuery.sln
echo "Publishing ~/engaze/git/EventQuery/Service/EventQuery.csproj to ~/engaze/api/eventquery/  folder."
dotnet publish --output ~/engaze/api/eventquery/ ~/engaze/git/EventQuery/Service/EventQuery.csproj
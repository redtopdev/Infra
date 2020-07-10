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
DIR=~/engaze/git/EventSubscriber/
if [ -d $DIR ]; then
  # Take action if $DIR exists. #
  echo "Cleaning up ~/engaze/git/EventSubscriber folder before cloning."
  rm -r -f ~/engaze/git/EventSubscriber/
else
  ###  Control will jump here if $DIR does NOT exists ###
  echo "${DIR} not found."
  
fi


echo "stopping Engaze.EventSubscriber.Service"
kill -9 $(ps aux | grep 'Engaze.EventSubscriber.Service' | awk '{print $2}')

echo "Cloning https://github.com/redtopdev/EventSubscriber.git"
git clone https://github.com/redtopdev/EventSubscriber.git
echo "Building ~/engaze/git/EventSubscriber/EventSubscriber.sln"
dotnet build --configuration debug ~/engaze/git/EventSubscriber/EventSubscriber.sln
echo "Publishing ~/engaze/git/EventSubscriber/Engaze.EventSubscriber/Engaze.EventSubscriber.csproj to ~/engaze/svc/eventsubscriber/  folder."
dotnet publish --output ~/engaze/svc/eventsubscriber/ ~/engaze/git/EventSubscriber/Engaze.EventSubscriber/Engaze.EventSubscriber.csproj
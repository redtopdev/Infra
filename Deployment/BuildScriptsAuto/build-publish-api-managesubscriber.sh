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
DIR=~/engaze/git/ManageSubscriber/
if [ -d $DIR ]; then
  # Take action if $DIR exists. #
  echo "Cleaning up ~/engaze/git/ManageSubscriber folder before cloning."
  rm -r -f ~/engaze/git/ManageSubscriber/
else
  ###  Control will jump here if $DIR does NOT exists ###
  echo "${DIR} not found."
  
fi


echo "stopping SubScriber.Service.dll"
kill $(ps aux | grep 'Subscriber.Service.dll' | awk '{print $2}')

echo "Cloning https://github.com/redtopdev/ManageSubscriber.git"
git clone https://github.com/redtopdev/ManageSubscriber.git
echo "Building ~/engaze/git/ManageSubscriber/All.sln"
dotnet build --configuration debug ~/engaze/git/ManageSubscriber/All.sln
echo "Publishing ~/engaze/git/ManageSubscriber/Service/Subscriber.csproj to ~/engaze/api/managesubscriber/  folder."
dotnet publish --output ~/engaze/api/managesubscriber/ ~/engaze/git/ManageSubscriber/Service/Subscriber.csproj
DIR=~/git/
if [ -d $DIR ]; then
  # Take action if $DIR exists. #
  echo "git folder exists"
else
  ###  Control will jump here if $DIR does NOT exists ###
  echo "Folder  ${DIR} not found. Creating the same."
  #mkdir ~/git/
fi

cd ~/git
DIR=~/git/ManageSubscriber/
if [ -d $DIR ]; then
  # Take action if $DIR exists. #
  echo "Cleaning up ~/git/ManageSubscriber folder before cloning."
  rm -r -f ~/git/ManageSubscriber/
else
  ###  Control will jump here if $DIR does NOT exists ###
  echo "${DIR} not found."
  
fi


echo "stopping SubScriber.Service.dll"
kill $(ps aux | grep 'Subscriber.Service.dll' | awk '{print $2}')

echo "Cloning https://github.com/redtopdev/ManageSubscriber.git"
git clone https://github.com/redtopdev/ManageSubscriber.git
echo "Building ~/git/ManageSubscriber/All.sln"
dotnet build --configuration debug ~/git/ManageSubscriber/All.sln
echo "Publishing ~/git/ManageSubscriber/Service/Subscriber.csproj to ~/engaze/api/managesubscriber/  folder."
dotnet publish --output ~/engaze/api/managesubscriber/ ~/git/ManageSubscriber/Service/Subscriber.csproj
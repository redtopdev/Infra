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
DIR=/home/$1/engaze/git/ManageSubscriber/
if [ -d $DIR ]; then
  # Take action if $DIR exists. #
  echo "Cleaning up /home/$1/engaze/git/ManageSubscriber folder before cloning."
  rm -r -f /home/$1/engaze/git/ManageSubscriber/
else
  ###  Control will jump here if $DIR does NOT exists ###
  echo "${DIR} not found."
  
fi


echo "stopping SubScriber.Service.dll"
kill $(ps aux | grep 'Subscriber.Service.dll' | awk '{print $2}')

echo "Cloning https://github.com/redtopdev/ManageSubscriber.git"
git clone https://github.com/redtopdev/ManageSubscriber.git
echo "Building /home/$1/engaze/git/ManageSubscriber/All.sln"
dotnet build --configuration debug /home/$1/engaze/git/ManageSubscriber/All.sln
echo "Publishing /home/$1/engaze/git/ManageSubscriber/Service/Subscriber.csproj to /home/$1/engaze/api/managesubscriber/  folder."
dotnet publish --output /home/$1/engaze/api/managesubscriber/ /home/$1/engaze/git/ManageSubscriber/Service/Subscriber.csproj
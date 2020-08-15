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
DIR=/home/$1/engaze/git/PushNotification/
if [ -d $DIR ]; then
  # Take action if $DIR exists. #
  echo "Cleaning up /home/$1/engaze/git/PushNotification folder before cloning."
  rm -r -f /home/$1/engaze/git/PushNotification/
else
  ###  Control will jump here if $DIR does NOT exists ###
  echo "${DIR} not found."
  
fi


echo "stopping Notification.Service.dll"
kill $(ps aux | grep 'Notification.Service.dll' | awk '{print $2}')

echo "Cloning https://github.com/redtopdev/PushNotification.git"
git clone https://github.com/redtopdev/PushNotification.git
echo "Building /home/$1/engaze/git/PushNotification/PushNotification.sln"
dotnet build --configuration debug /home/$1/engaze/git/PushNotification/PushNotification.sln
echo "Publishing /home/$1/engaze/git/PushNotification/Service/Notification.csproj to /home/$1/engaze/api/pushnotification/  folder."
dotnet publish --output /home/$1/engaze/api/pushnotification/ /home/$1/engaze/git/PushNotification/Service/Notification.csproj
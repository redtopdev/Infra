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
DIR=/home/$1/engaze/git/EventSubscriber/
if [ -d $DIR ]; then
  # Take action if $DIR exists. #
  echo "Cleaning up /home/$1/engaze/git/EventSubscriber folder before cloning."
  rm -r -f /home/$1/engaze/git/EventSubscriber/
else
  ###  Control will jump here if $DIR does NOT exists ###
  echo "${DIR} not found."
  
fi


echo "stopping Engaze.EventSubscriber.Service"
kill -9 $(ps aux | grep 'Engaze.EventSubscriber.Service' | awk '{print $2}')

echo "Cloning https://github.com/redtopdev/EventSubscriber.git"
git clone https://github.com/redtopdev/EventSubscriber.git
echo "Building /home/$1/engaze/git/EventSubscriber/EventSubscriber.sln"
dotnet build --configuration debug /home/$1/engaze/git/EventSubscriber/EventSubscriber.sln
echo "Publishing /home/$1/engaze/git/EventSubscriber/Engaze.EventSubscriber/Engaze.EventSubscriber.csproj to /home/$1/engaze/svc/eventsubscriber/  folder."
dotnet publish --output /home/$1/engaze/svc/eventsubscriber/ /home/$1/engaze/git/EventSubscriber/Engaze.EventSubscriber/Engaze.EventSubscriber.csproj
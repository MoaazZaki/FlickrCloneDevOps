#!/bin/bash
#!/bin/sh
#Pulling the latest images
sudo docker-compose pull
#Set the repos names
SERVER="moaazzaki/flickr-server"
CLIENT="moaazzaki/flickr-client"
#Loop auto-deployment
while true
do
  echo "(1/5)Checking new updates"
  IS_OLD_server=$(./get_image_digest.sh $SERVER latest)
  IS_OLD_client=$(./get_image_digest.sh $CLIENT latest)
  if [ "$IS_OLD_server" = "false" ] || [ "$IS_OLD_client" = "false" ]; 
  then
  sudo docker-compose stop  
  echo "(2/5)Removing.."
  sudo docker-compose rm -f
  echo "(3/5)pulling.."
  sudo docker-compose pull
  fi
  echo "(4/5)building.."
  sudo docker-compose up -d
  sudo docker image prune -a --force --filter "label!=gcr.io/datadoghq/agent"
  echo "(5/5)sleeping.."
  sleep 60
done


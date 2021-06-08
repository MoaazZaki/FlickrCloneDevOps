#!/bin/bash
#Install all dependencies (JSON - Docker - nginx - openjdk - jenkins)
cd
sudo apt update
sudo apt install jq
sudo snap install docker 
sudo apt-get install curl
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo apt install nginx
#Login to docker-hub account
sudo docker login -u "$DOCKERUSER" -p "$DOCKERPASS"
#Update Nginx configs
cd /etc/nginx/sites-enabled
sudo chmod 777 default
cp ~/FlickrCloneDevOps/default default
cd
sudo nginx -s reload
#Installing Datadog agent for monitoring 
sudo docker run -d --rm --name dd-agent -v /var/run/docker.sock:/var/run/docker.sock:ro -v /proc/:/host/proc/:ro -v /sys/fs/cgroup/:/host/sys/fs/cgroup:ro -e DD_API_KEY=b5ab94713bb50f242a6b43aa21b2f4fa -e DD_SITE="datadoghq.com" gcr.io/datadoghq/agent:7
#Starting hosting setup
cd FlickrCloneDevOps
sudo mv client Flickr-Frontend
sudo mv server FlickrCloneBE
chmod 777 get*
sudo snap install core; sudo snap refresh core
sudo snap install --classic certbot
sudo certbot --nginx
sudo certbot renew --dry-run
sudo nginx -s reload
#Pulling deployed images
sudo docker-compose pull
#Setting auto restart for crashes
sudo docker update --restart unless-stopped $(sudo docker ps -q)
#Starting auto deployment
sh auto_update.sh
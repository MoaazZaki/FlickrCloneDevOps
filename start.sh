#!/bin/bash
sudo apt update
sudo apt install jq
sudo snap install docker 
sudo apt install nginx
#sudo apt-get install yarn
sudo docker login -u "$DOCKERUSER" -p "$DOCKERPASS"
git clone https://"$GITUSER":"$GITPASS"@github.com/MoaazZaki/FlickrCloneDevOps.git
cd /etc/nginx/sites-enabled
sudo chmod 777 default
cp ~/FlickrCloneDevOps/default default
cd
sudo nginx -s reload
sudo docker run -d --rm --name dd-agent -v /var/run/docker.sock:/var/run/docker.sock:ro -v /proc/:/host/proc/:ro -v /sys/fs/cgroup/:/host/sys/fs/cgroup:ro -e DD_API_KEY=b5ab94713bb50f242a6b43aa21b2f4fa -e DD_SITE="datadoghq.com" gcr.io/datadoghq/agent:7
cd FlickrCloneDevOps

sudo mv client Flickr-Frontend
sudo mv server FlickrCloneBE

chmod 777 get*


sudo snap install core; sudo snap refresh core
sudo snap install --classic certbot
sudo certbot --nginx
sudo certbot renew --dry-run
sudo nginx -s reload

sh auto_update.sh #this need to be deattach
sudo docker update --restart unless-stopped $(sudo docker ps -q)

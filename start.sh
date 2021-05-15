#!/bin/bash
sudo apt update
sudo apt install jq
sudo snap install docker 
sudo apt install nginx
sudo docker login -u <user> -p <password>
git clone https://<user>:<password>@github.com/MoaazZaki/jdc-trial.git
cd /etc/nginx/sites-enabled
sudo chmod 777 default
cp ~/jdc-trial/default default
cd
sudo nginx -s reload
sudo docker run -d --rm --name dd-agent -v /var/run/docker.sock:/var/run/docker.sock:ro -v /proc/:/host/proc/:ro -v /sys/fs/cgroup/:/host/sys/fs/cgroup:ro -e DD_API_KEY=b5ab94713bb50f242a6b43aa21b2f4fa -e DD_SITE="datadoghq.com" gcr.io/datadoghq/agent:7
cd jdc-trial
sh auto_update.sh
sudo docker update --restart unless-stopped $(sudo docker ps -q)

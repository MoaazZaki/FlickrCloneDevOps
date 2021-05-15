#!/bin/bash
cd jdc-trial
sudo docker image rm moaazzaki/jdc-client moaazzaki/jdc-server -f
sudo docker-compose up
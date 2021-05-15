#!/bin/bash
REPOSITORY=$1
TARGET_TAG=$2
# get authorization token
TOKEN=$(curl -s "https://auth.docker.io/token?service=registry.docker.io&scope=repository:$REPOSITORY:pull" | jq -r .token )
# get image digest for target
TARGET_DIGEST=$(curl -s -D - -H "Authorization: Bearer $TOKEN" -H "Accept: application/vnd.docker.distribution.manifest.v2+json" https://index.docker.io/v2/$REPOSITORY/manifests/$TARGET_TAG | grep docker-content-digest | cut -d ' ' -f 2 | head -n 1 | tr -d '\r')
echo $TARGET_DIGEST
# pulled iamge digest
CURRENT_DIGEST=$(sudo docker image inspect "$REPOSITORY:$TARGET_TAG" --format '{{json .RepoDigests}}' | jq . | grep $REPOSITORY | sed 's/.$//' | sed 's/^.*\(sha.*\).*$/\1/') 
echo $CURRENT_DIGEST
# check digest
  if [ "$TARGET_DIGEST" = "$CURRENT_DIGEST" ]; then
    echo "true"
  else
    echo "false"
  fi


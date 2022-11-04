#!/bin/bash
USER=ronaldbaltus
IMAGE_NAME=minecraft-bedrock-server
DOWNLOAD_PAGE_URL=https://www.minecraft.net/en-us/download/server/bedrock
DOWNLOAD_URL=$(wget -q --user-agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/97.0.4692.99 Safari/537.36 OPR/83.0.4254.70" -O - $DOWNLOAD_PAGE_URL | grep "https://minecraft.azureedge.net/bin-linux/bedrock-server-" | perl -n -e'/(https:\/\/minecraft.azureedge.net\/bin-linux\/[^\"]+)/ && print $1')
VERSION=$(echo -e $DOWNLOAD_URL | perl -n -e'/bedrock-server-([\d.]+)\.zip$/ && print $1')

echo "Found version ${VERSION}"

# check if we have it
if [ -n "$USER" ]
then
    EXISTS=$(docker manifest inspect $USER/$IMAGE_NAME:$VERSION > /dev/null ; echo $(( ! "$?" )))
else
    EXISTS=$(docker images | grep $IMAGE_NAME | grep $VERSION | wc -l)
fi

if [[ "$EXISTS" -gt "0" ]]
then
    echo "Version ${VERSION} already present"
else
    docker build -t $IMAGE_NAME:$VERSION --build-arg VERSION=$VERSION .

    if [ -n "$USER" ]
    then
        echo "Pushing ${VERSION} to ${USER}"
        docker tag $IMAGE_NAME:$VERSION $USER/$IMAGE_NAME:$VERSION
        docker tag $IMAGE_NAME:$VERSION $USER/$IMAGE_NAME:latest
        docker push $USER/$IMAGE_NAME:$VERSION
        docker push $USER/$IMAGE_NAME:latest
    fi
fi

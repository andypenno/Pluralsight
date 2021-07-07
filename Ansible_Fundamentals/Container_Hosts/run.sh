#!/bin/bash
#
#   A.Pennington (02-07-2021)

## Check if docker compose is already installed
if ! `command -v docker-compose &> /dev/null`
then
	echo "Please install docker compose."
  exit
fi

ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

## Bring up the project
docker-compose -f $ROOT_DIR/docker-compose.yml up -d 
if [ $? -ne 0 ]
then
    echo "An error occured whilst bringing up the project."
    exit
fi

NETWORK="$(docker network inspect container_hosts_default -f '{{range .IPAM.Config}}{{.Gateway}}{{end}}')"

printf "To connect to a client:\n\tsudo ssh -p <PORT NUMBER> -i $ROOT_DIR/ssh/id_rsa root@$NETWORK\n"
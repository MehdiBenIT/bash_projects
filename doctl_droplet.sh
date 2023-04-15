#!/bin/bash

echo "##################################################"
echo "         Welcome on the doctl script!          "
echo "This script will simplify and help you to deploy
quickly a droplet on Digital ocean thanks to cli!"
echo "##################################################"

read -p "Which name do you want to affect to this droplet ?" name_droplet
read -p "How many droplets do you want to create ?" nb_droplet
start=0

if [ $nb_droplet -gt 1]
then
    while [ $start -lt $nb_droplet ]
    do
        echo "Creating a droplet..."
        start=$(( $start + 1 ))
    done
fi
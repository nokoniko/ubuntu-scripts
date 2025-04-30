#!/bin/bash


# lager en folder med navn minecraft_server for å ha det rydig
mkdir -p minecraft_server
cd minecraft_server

# laster temux og java jdk
sudo apt update 
sudo apt install tmux openjdk-21-jdk-headless -y
# laster ned den nyeste versonen av paper for at bedrock og java kan spille på samme server
wget https://api.papermc.io/v2/projects/paper/versions/1.21.4/builds/227/downloads/paper-1.21.4-227.jar -O paper.jar

# gjør som at den eutomatisk agreeer til eulaen
echo "eula=true" > eula.txt

# lager en ny folder med navn plugins
mkdir -p plugins 
wget https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/spigot -O plugins/Geyser-Spigot.jar # laster ned bedrock suport

tmux new-session -d -s minecraft "java -Xmx1024M -Xms1024M -jar paper.jar nogui" # runner serveren

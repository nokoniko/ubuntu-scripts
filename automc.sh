#!/bin/bash

echo "Hva vil du kalle folderen?"
read serverfolder

# Lager mappen og går inn i den
mkdir -p "$serverfolder"
cd "$serverfolder" || exit

# Oppdater og installer nødvendige pakker
sudo apt update 
sudo apt install tmux openjdk-21-jdk-headless -y

# Last ned PaperMC (Java-server som støtter plugins)
wget https://api.papermc.io/v2/projects/paper/versions/1.21.4/builds/227/downloads/paper-1.21.4-227.jar -O paper.jar

# Lag plugins-mappen og last ned Geyser
mkdir -p plugins 
wget https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/spigot -O plugins/Geyser-Spigot.jar

echo "‘\033[0;32mfår å starte serveren gjør tmux new-session -d -s minecraft "java -Xmx1024M -Xms1024M -jar paper.jar nogui""

#!/bin/bash

# spør om hav du vill kalle mappen for
read "Hva vil du kalle mappen for" mappenavn

# spør om du vill ha bedrock eller ikke 
read "skall den ha bedrock support? y/n: " valg

# Lager mappen og går inn i den
mkdir -p "$mappenavn"
cd "$mappenavn" || exit


# Oppdater og installer nødvendige pakker
sudo apt update 
sudo apt install -y tmux openjdk-21-jdk-headless wget sl

# om du svarer "y" vill den laste ned alt du trenger til bedrock support

#                                                             ------ BEDROCK ------

if [ "$valg" = "y"]; then
# Last ned PaperMC (Java-server som støtter plugins)
wget https://api.papermc.io/v2/projects/paper/versions/1.21.4/builds/227/downloads/paper-1.21.4-227.jar || { echo "Feil under nedlasting av PaperMC."; exit 1; }

# Lag en plugins mappe og last ned geyser
mkdir -p plugins 
wget https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/spigot -O plugins/Geyser-Spigot.jar || { echo "Feil under nedlasting av Geyser."; exit 1; }

# Sjekk om tmux sesjonen allerede finnes og avslutt den om nødvendig
tmux has-session -t minecraft 2>/dev/null
if [ $? == 0 ]; then
  tmux kill-session -t minecraft
  echo "Tømte eksisterende tmux-sesjon."
fi

# automatisk godtar euulaen til mojang
echo "eula=true" > eula.txt

# starter en tmux session
tmux new-session -s minecraft "java -Xmx1024M -Xms1024M -jar paper-1.21.4-227.jar nogui"

#                                                             ------ VANILLA ------

# om du svarer "n" lager den en offisiel server
elif if [ "$valg" = "n"]; then

# får minecraft server jaren fra mojangs offisiele nettside
wget https://launcher.mojang.com/v1/objects/1b4a79cc4ac7f67bb6d913478efb78c4eebfd74e/server.jar -O minecraft_server.jar || { echo "Feil under nedlasting av minecraft server jar."; exit 1; }

# Sjekk om tmux sesjonen allerede finnes og avslutt den om nødvendig
tmux has-session -t minecraft 2>/dev/null
if [ $? == 0 ]; then
  tmux kill-session -t minecraft
  echo "Tømte eksisterende tmux session"
fi

# automatisk godtar eulaen til mojang
echo "eula=true" > eula.txt

# starter en tmux session
tmux new-session -s minecraft "java -Xmx1024M -Xms1024M -jar minecraft_server.jar nogui"

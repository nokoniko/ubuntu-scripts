#!/bin/bash

# Oppdater og installer nødvendige pakker
sudo apt update 
sudo apt install -y tmux openjdk-21-jdk-headless wget sl

# spør om hav du vill kalle mappen for
echo "Hva vil du kalle mappen for"
read mappenavn

# Lager mappen og går inn i den
mkdir -p "$mappenavn"
cd "$mappenavn" || exit

# får minecraft server jaren fra mojangs offisiele nettside
wget https://launcher.mojang.com/v1/objects/1b4a79cc4ac7f67bb6d913478efb78c4eebfd74e/server.jar || { echo "Feil under nedlasting av minecraft server jar."; exit 1; }

# Sjekk om tmux sesjonen allerede finnes og avslutt den om nødvendig
tmux has-session -t minecraft 2>/dev/null
if [ $? == 0 ]; then
  tmux kill-session -t minecraft
  echo "Tømte eksisterende tmux session"
fi

# automatisk godtar eulaen til mojang
echo "eula=true" > eula.txt

# starter en tmux session
tmux new-session -s minecraft "java -Xmx1024M -Xms1024M -jar server.jar nogui"

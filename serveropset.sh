#!/bin/bash

# oppdater og installer nødvendige pakker
sudo apt update
sudo apt install -y tmux openjdk-21-jdk-headless wget sl

# spør om hva du vil kalle mappen
echo "Hva vil du kalle mappen?"
read mappenavn

# spør om det skal ha bedrock-support
echo "Skal den ha bedrock-support? y/n: "
read valg

# lager mappen og går inn i den
mkdir -p "$mappenavn"
cd "$mappenavn" || exit

# laster ned starteren får serveren
wget wget https://raw.githubusercontent.com/nokoniko/automatisk-paper-server-ubuntu/refs/heads/main/start.sh
chmod +x start.sh

if [ "$valg" = "y" ]; then
    # Last ned PaperMC
    wget https://api.papermc.io/v2/projects/paper/versions/1.21.4/builds/227/downloads/paper-1.21.4-227.jar || { echo "Feil under nedlasting av PaperMC."; exit 1; }

    # Lag plugins-mappe og last ned Geyser
    mkdir -p plugins
    wget https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/spigot -O plugins/Geyser-Spigot.jar || { echo "Feil under nedlasting av Geyser."; exit 1; }

    # Tøm eventuell eksisterende tmux-sesjon
    tmux has-session -t minecraft 2>/dev/null
    if [ $? == 0 ]; then
        tmux kill-session -t minecraft
        echo "Tømte eksisterende tmux-sesjon."
    fi
    
    # auto akseptere mojangs eula
    echo "eula=true" > eula.txt

    # starter en ny tmux session med paper serveren
    tmux new-session -s minecraft "java -Xmx1024M -Xms1024M -jar paper-1.21.4-227.jar nogui"

elif [ "$valg" = "n" ]; then
    # laster ned mojang serveren fra den offisile nestiden
    wget https://launcher.mojang.com/v1/objects/1b4a79cc4ac7f67bb6d913478efb78c4eebfd74e/server.jar || { echo "Feil under nedlasting av Minecraft server."; exit 1; }

    # sjekker om det alerede er en tmux 
    tmux has-session -t minecraft 2>/dev/null
    if [ $? == 0 ]; then
        tmux kill-session -t minecraft
        echo "Tømte eksisterende tmux-sesjon."
    fi

    # auto akseptere mojangs eula
    echo "eula=true" > eula.txt

    # starter en ny tmux session med mojang serveren
    tmux new-session -s minecraft "java -Xmx1024M -Xms1024M -jar server.jar nogui"
else
    echo "Ugyldig valg. Skriv y eller n."
fi

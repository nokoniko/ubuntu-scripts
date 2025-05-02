#!/bin/bash

# oppdater og installer nødvendige pakker
sudo apt update
sudo apt install -y tmux openjdk-21-jdk-headless wget sl

# spør om hva du vil kalle mappen
read -p $'\e[32mHva vil du kalle mappen? \e[0m' mappenavn

# spør om det skal ha bedrock-support
read -p $'\e[32mSkal den ha bedrock-support? (y/n) \e[0m: ' valg

# spør om du vill ha starter scriptet
read  -p $'\e[32mVil du ha start.sh som vil starte riktig server? (y/n): \e[0m' valg2
echo -e "\e[35m"
# lager mappen og går inn i den
mkdir -p "$mappenavn"
cd "$mappenavn" || exit

if [ "$valg2" = "y" ]; then
    # laster ned starteren får serveren
    wget https://raw.githubusercontent.com/nokoniko/automatisk-paper-server-ubuntu/refs/heads/main/start.sh
    chmod +x start.sh
else
    echo -e "\e[31mUgyldig valg. Skriv y eller n.\e[0m"
fi

if [ "$valg" = "y" ]; then
    # Last ned PaperMC
    wget https://api.papermc.io/v2/projects/paper/versions/1.21.4/builds/227/downloads/paper-1.21.4-227.jar || { echo -e "\e[31mFeil under nedlasting av PaperMC.\e[0m"; exit 1; }

    # Lag plugins-mappe og last ned Geyser
    mkdir -p plugins
    wget https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/spigot -O plugins/Geyser-Spigot.jar || { echo -e "\e[31mFeil under nedlasting av Geyser.\e[0m"; exit 1; }

    # Tøm eventuell eksisterende tmux session
    tmux has-session -t minecraft 2>/dev/null
    if [ $? == 0 ]; then
        tmux kill-session -t minecraft
        echo -e "\e[32mTømte eksisterende tmux session.\e[0m"
    fi
    
    # auto akseptere mojangs eula
    echo "eula=true" > eula.txt

    # starter en ny tmux session med paper serveren
    tmux new-session -s minecraft "java -Xmx1024M -Xms1024M -jar paper-1.21.4-227.jar nogui"

elif [ "$valg" = "n" ]; then
    # laster ned mojang serveren fra den offisile nestiden
    wget https://launcher.mojang.com/v1/objects/1b4a79cc4ac7f67bb6d913478efb78c4eebfd74e/server.jar || { echo -e "\e[31mFeil under nedlasting av Minecraft server.\e[0m"; exit 1; }

    # sjekker om det alerede er en tmux 
    tmux has-session -t minecraft 2>/dev/null
    if [ $? == 0 ]; then
        tmux kill-session -t minecraft
        echo -e "\e[32mTømte eksisterende tmux session.\e[0m"
    fi

    # auto akseptere mojangs eula
    echo "eula=true" > eula.txt

    # starter en ny tmux session med mojang serveren
    tmux new-session -s minecraft "java -Xmx1024M -Xms1024M -jar server.jar nogui"
else
    echo -e "\e[31mUgyldig valg. Skriv y eller n.\e[0m"
fi

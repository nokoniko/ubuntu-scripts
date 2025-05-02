#!/bin/bash

# spør om hav du vill kalle mappen for
read "Hva vil du kalle mappen for" mappenavn

# Lager mappen og går inn i den
mkdir -p "$mappenavn"
cd "$mappenavn" || exit

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

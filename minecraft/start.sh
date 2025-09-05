#!/bin/bash

# spør om du vill ha bedrock eller ikke 
read "\e[32mer det en vanilla eller paper server vanilla/paper: \e[0m" valg
#                                                        ------ bedrock ------
# om man svarer bedrock vill den starte paper serveren    
# Tøm eventuell eksisterende tmux session
tmux has-session -t minecraft 2>/dev/null
    if [ $? == 0 ]; then
        tmux kill-session -t minecraft
        echo -e "\e[32mTømte eksisterende tmux-session.\e[0m"
    fi

if [ "$valg" = "bedrock"]                                  
    # starter paper servere med tmux                                        
    tmux new-session -s minecraft "java -Xmx1024M -Xms1024M -jar paper-1.21.4-227.jar nogui"
    # om man svarer vanilla vill den starte en vanilla/mojang server
    #                                                        ------ VANILLA ------
elif [ "$valg" = "vanilla"]
    # starter vanilla serveren med tmux
    tmux new-session -s minecraft "java -Xmx1024M -Xms1024M -jar minecraft_server.jar nogui"
else
    echo "\e[31mUgyldig valg. Skriv enten vanilla eller paper.\e[0m"
fi

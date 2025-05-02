#!/bin/bash

# sjekker hvilen filler du har 
ls
# sprø om hvilken mappe du vill gå in i
echo "hvilken mappe vill du gå in i? "
read mappenavn

cd "$mappenavn" || exit

# spør om du vill ha bedrock eller ikke 
read "er det en vanilla eller paper server vanilla/paper: " valg
# starter en ny temux session
#                                                        ------ bedrock ------
# om man svarer bedrock vill den starte paper serveren    
if [ "$valg" = "bedrock"]                                  
# starter paper servere med tmux                                        
tmux new-session -s minecraft "java -Xmx1024M -Xms1024M -jar paper-1.21.4-227.jar nogui"
# om man svarer vanilla vill den starte en vanilla/mojang server
#                                                        ------ VANILLA ------
elif [ "$valg" = "vanilla"]
# starter vanilla serveren med tmux
tmux new-session -s minecraft "java -Xmx1024M -Xms1024M -jar minecraft_server.jar nogui"
else
    echo "Ugyldig valg. Skriv enten vanilla eller paper."
fi

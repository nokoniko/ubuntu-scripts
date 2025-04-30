#!/bin/bash

# sjekker hvilen filler du har 
ls

# sprø om hvilken mappe du vill gå in i
echo "hvilken mappe vill du gå in i? "
read mappenavn

cd "$mappenavn"

# starter en ny temux session
tmux new-session -d -s minecraft "java -Xmx1024M -Xms1024M -jar paper-1.21.4-227.jar nogui"
#!/bin/bash

read -p "[?] Hva skal brukernavnet være?: " USERNAME

while true; do
    echo "!!HUSK!! DU MÅ huske passordet."
    read -s -p "[?] Skriv inn passordet (minst 8 tegn og ett spesialtegn): " PASS1
    read -s -p "[!] Bekreft passordet: " PASS2
    echo

    if [ "$PASS1" != "$PASS2" ]; then
        echo "[!] Feil: passordene matcher ikke. Prøv igjen."
        continue
    fi

    if [[ ${#PASS1} -lt 8 || ! "$PASS1" =~ [^a-zA-Z0-9] ]]; then
        echo "[!] Feil: passordet må være minst 8 tegn og inneholde minst ett spesialtegn."
        continue
    fi

    PASSWORD="$PASS1"
    break
done

read -s -p "[?] MySQL root-passord: " ROOT_PASS
echo

# Opprett bruker
sudo useradd -m -s /bin/bash "$USERNAME"
echo "$USERNAME:$PASSWORD" | sudo chpasswd
sudo usermod -aG sudo "$USERNAME"

# Installer LAMP som den nye brukeren
sudo -i -u "$USERNAME" bash << EOF
sudo apt update -y && sudo apt upgrade -y
sudo apt install lamp-server^ -y
sudo systemctl start mysql && sudo systemctl enable mysql

sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$ROOT_PASS'; FLUSH PRIVILEGES;"
sudo mysql -e "DELETE FROM mysql.user WHERE User='';"
sudo mysql -e "DROP DATABASE IF EXISTS test;"
sudo mysql -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';"
EOF


echo "[✔] Bruker og LAMP/MySQL er ferdig satt opp!"
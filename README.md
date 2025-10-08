# Ubuntu Scripts

Dette repoet inneholder diverse skript for å automatisere oppsett på Ubuntu.

## Minecraft Server Oppsett

Dette skriptet automatiserer oppsettet av en Minecraft Java Edition-server (Vanilla eller PaperMC) på Ubuntu.

### Bruk

Kjør følgende kommandoer i terminalen for å laste ned og kjøre skriptet:
```bash
wget https://raw.githubusercontent.com/nokoniko/ubuntu-scripts/main/minecraft/serveropset.sh
chmod +x serveropset.sh
./serveropset.sh
```

Skriptet vil guide deg gjennom prosessen, inkludert valg av servertype (med eller uten Bedrock-støtte via GeyserMC) og installasjon av et hjelpeskript (`start.sh`) for å starte serveren senere.

## LAMP Stack Oppsett

Dette skriptet setter opp en full LAMP-stack (Linux, Apache, MySQL, PHP) på Ubuntu. Det oppretter også en ny bruker med `sudo`-rettigheter.

### Bruk

**Advarsel:** Dette skriptet må kjøres som `root`-brukeren, da det oppretter en ny systembruker.

Kjør følgende kommandoer i terminalen:
```bash
wget https://raw.githubusercontent.com/nokoniko/ubuntu-scripts/main/adnre_scripts/lamp-setup.sh
chmod +x lamp-setup.sh
sudo ./lamp-setup.sh
```
Du må runne dette på root fordi den lager en ny bruker med sudo perms.

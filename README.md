# Ubuntu-skript

Dette repoet inneholder diverse skript for å automatisere oppsett på Ubuntu.

## Kom i gang

Du kan enten klone hele repositoryet for å få tilgang til alle skript, eller laste ned individuelle skript ved behov.

### Klon repositoryet (Anbefalt)

```bash
git clone https://github.com/nokoniko/ubuntu-scripts.git
cd ubuntu-scripts
chmod +x build.sh
./build.sh
```

## Minecraft Server Oppsett

Disse skriptene automatiserer oppsettet av en Minecraft Java Edition-server (Vanilla eller PaperMC) på Ubuntu.

### Metode 1: Online-installasjon (Anbefalt)

Denne metoden bruker et lite skript som alltid laster ned og kjører den nyeste versjonen av hovedskriptet.

```bash
bash <(curl -s https://raw.githubusercontent.com/nokoniko/ubuntu-scripts/main/minecraft/online.sh)
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

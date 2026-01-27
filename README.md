
# Ajout d'une IP lan (switch)

sudo ip addr add 10.0.0.11/24 dev eth0

sudo ip link set eth0 up

- pour verifier

ip a show eth0
ping 10.0.0.10   # ping vers PC

#Ajout de l'IP en crontab

sudo apt update

sudo apt install cron -y        # Installer cron

sudo systemctl enable cron      # Activer cron au démarrage

sudo systemctl start cron       # Démarrer le service cron

sudo systemctl status cron      # Vérifier que cron fonctionne



sudo crontab -e

@reboot /sbin/ip addr add 10.0.0.XX/24 dev eth0 && /sbin/ip link set eth0 up


sudo crontab -l

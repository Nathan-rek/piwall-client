#!/bin/bash


# 1️⃣ Définir la vidéo : soit deuxième argument, soit vidéo par défaut dans ./video/
VIDEO=${2:-"video/video.mp4"}  # chemin relatif au dossier du script
SOCKET="/tmp/mpvsocket"
CMD=$1  # play / pause / stop

# 2️⃣ Supprimer socket existant si mpv déjà lancé
rm -f $SOCKET

# 3️⃣ Lancer mpv si pas déjà lancé
pgrep mpv > /dev/null || nohup mpv --fs --no-border --input-ipc-server=$SOCKET "$VIDEO" >/dev/null 2>&1 &
sleep 1

# 4️⃣ Gérer les commandes
case $CMD in
    play)
        echo '{ "command": ["set_property", "pause", false] }' | socat - UNIX-CONNECT:$SOCKET
        ;;
    pause)
        echo '{ "command": ["set_property", "pause", true] }' | socat - UNIX-CONNECT:$SOCKET
        ;;
    stop)
        pkill mpv
        ;;
    *)
        echo "Commande inconnue : $CMD"
        ;;
esac

wait

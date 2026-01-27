#!/bin/bash

VIDEO=${2:-"$BASEDIR/video/video.mp4"} # 2ème argument = chemin vidéo
SOCKET="/tmp/mpvsocket"
CMD=$1  # play / pause / stop

# Supprimer socket existant si mpv déjà lancé
rm -f $SOCKET

# Lancer mpv si pas déjà lancé
# Lancer mpv si pas déjà lancé
pgrep mpv > /dev/null || nohup mpv --fs --no-border --input-ipc-server=$SOCKET "$VIDEO" >/dev/null 2>&1 &
sleep 1

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

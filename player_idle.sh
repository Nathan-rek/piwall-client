#!/bin/bash
# player_idle.sh
# Lancer mpv en idle pour qu'il accepte les commandes IPC
SOCKET="/tmp/mpvsocket"
VIDEO="/home/pi-nath/Documents/piwall-client/video/video.mp4" # peut être un fichier muet

# Lancer mpv si pas déjà lancé
if ! pgrep mpv >/dev/null; then
    nohup mpv --fs --no-border --input-ipc-server=$SOCKET --idle "$VIDEO" >/dev/null 2>&1 &
    echo "mpv lancé en idle, socket prêt"
else
    echo "mpv déjà lancé"
fi

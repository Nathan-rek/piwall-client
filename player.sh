#!/bin/bash

CMD=$1
VIDEO=${2:-"video/video.mp4"}
START_AT=$3
SOCKET="/tmp/mpvsocket"

export DISPLAY=:0

# Nettoyage
pkill mpv 2>/dev/null
rm -f "$SOCKET"

# Attente sync si demandée
if [ -n "$START_AT" ]; then
  NOW=$(date +%s.%N)
  DELAY=$(echo "$START_AT - $NOW" | bc)
  if (( $(echo "$DELAY > 0" | bc -l) )); then
    sleep "$DELAY"
  fi
fi

# Lancer mpv DIRECTEMENT avec la vidéo
nohup mpv --fs --no-border --input-ipc-server="$SOCKET" "$VIDEO" \
  >/dev/null 2>&1 &

sleep 0.5

# Commandes simples
case "$CMD" in
  play|play_at)
    echo '{ "command": ["set_property", "pause", false] }' \
      | socat - UNIX-CONNECT:"$SOCKET"
    ;;
  pause)
    echo '{ "command": ["set_property", "pause", true] }' \
      | socat - UNIX-CONNECT:"$SOCKET"
    ;;
  stop)
    pkill mpv
    ;;
esac

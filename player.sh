#!/bin/bash

CMD=$1
VIDEO=${2:-"$HOME/Documents/piwall-client/video/video.mp4"}
SOCKET="/tmp/mpvsocket"

export DISPLAY=:0
export XAUTHORITY="$HOME/.Xauthority"

if ! pgrep mpv >/dev/null; then
    mpv --fs --no-border \
        --input-ipc-server="$SOCKET" \
        --no-terminal \
        "$VIDEO" &
    sleep 1
fi

case "$CMD" in
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
        echo "Usage: play|pause|stop [video]"
        ;;
esac


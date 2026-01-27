#!/bin/bash

CMD="$1"


VIDEO_DIR="/home/pi-nath/Documents/piwall-client/video"


VIDEO1="$VIDEO_DIR/video.mp4"
VIDEO2="$VIDEO_DIR/video.mp4"

SOCKET="/tmp/mpvsocket"

case "$CMD" in
    start)
        rm -f "$SOCKET"

        nohup mpv \
            "$VIDEO1" \
            --external-file="$VIDEO2" \
            --lavfi-complex='[vid1]scale=960x540[vid1s];[vid2]scale=960x540[vid2s];[vid1s][vid2s]hstack[vo]' \
            --fs \
            --no-border \
            --input-ipc-server="$SOCKET" \
            >/dev/null 2>&1 &
        ;;
    play)
        echo '{ "command": ["set_property", "pause", false] }' \
        | socat - UNIX-CONNECT:"$SOCKET"
        ;;
    pause)
        echo '{ "command": ["set_property", "pause", true] }' \
        | socat - UNIX-CONNECT:"$SOCKET"
        ;;
    stop)
        pkill mpv
        rm -f "$SOCKET"
        ;;
    *)
        echo "Usage:"
        echo "  $0 start"
        echo "  $0 play"
        echo "  $0 pause"
        echo "  $0 stop"
        ;;
esac


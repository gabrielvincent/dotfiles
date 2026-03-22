#!/bin/bash
# Monitor swayosd-server and restart it when it crashes (known GTK4/Wayland segfault)
while true; do
    if ! pgrep -x swayosd-server > /dev/null; then
        swayosd-server &
    fi
    sleep 5
done

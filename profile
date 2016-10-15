# Start pulse audio
pulseaudio --start 2>/dev/null
# Start music player daemon
mpd ~/.config/mpd/mpd.conf
# Start email synchronization
~/.local/sbin/syncemail
# Start syncthing
start-stop-daemon -S -bm -p /tmp/syncthing-$UID.pid  -- sh -c "syncthing -no-browser 2>&1 | logger -t syncthing"

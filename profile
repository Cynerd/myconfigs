# Start pulse audio
pulseaudio --start 2>/dev/null
# Start music player daemon
mpd ~/.config/mpd/mpd.conf
# Start email synchronization
~/.local/sbin/syncemail

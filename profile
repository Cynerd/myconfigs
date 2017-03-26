# Rest of the profile run only if login is from linux console
[[ "$(tty)" != /dev/tty* ]] && return

# Start pulse audio
pulseaudio --start 2>/dev/null
# Start music player daemon
mpd ~/.config/mpd/mpd.conf
# Start email synchronization
~/.local/sbin/syncemail
# And if we are on first terminal also automatically start x server
[ "$(tty)" = "/dev/tty1" ] && startx

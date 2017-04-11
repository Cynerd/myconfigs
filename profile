# First global user configuration
export PATH=~/.local/bin:$PATH:$(ruby -e "print Gem.user_dir")/bin
export EDITOR=vim

# Rest of the profile run only if login is from linux console
[[ "$(tty)" != /dev/tty* ]] && return

# Start music player daemon
~/.service/mpd -q status || ~/.service/mpd start
# Start email synchronization
~/.local/sbin/syncemail
# Start syncthing
~/.service/syncthing -q status || ~/.service/syncthing start

# And if we are on first terminal also automatically start x server
[ "$(tty)" = "/dev/tty1" ] && exec startx -- vt1

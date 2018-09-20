# First global user configuration
export PATH="~/.local/bin:$PATH:$(ruby -e "print Gem.user_dir")/bin:$HOME/.local/avr/bin"
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
if [ "$(tty)" = "/dev/tty1" ]; then
	if which annoyme >/dev/null 2>&1; then # Check if we are using annoyme
		sleep 1 # just little bit of time to give systemd to start tasks
		ls ~/.annoyme/*.pid 2>/dev/null >&2 && annoyme
	fi
	exec startx -- vt1
fi

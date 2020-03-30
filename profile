# First global user configuration
export PATH="$HOME/.local/bin:$PATH"
export EDITOR=vim

# Rest of the profile run only if login is from linux console
[[ "$(tty)" != /dev/tty* ]] && return

# Start music player daemon
~/.service/mpd -q status || ~/.service/mpd start
# Start email synchronization
#~/.local/sbin/syncemail
# Start syncthing
~/.service/syncthing -q status || ~/.service/syncthing start

# And if we are on first terminal also automatically start x server
if [ "$(tty)" = "/dev/tty1" ]; then
	exec startx -- vt1
fi

# Nix
[ ! -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ] || \
	. "$HOME/.nix-profile/etc/profile.d/nix.sh" # added by Nix installer

echo
echo "(1) i3"
echo "(2) sway"
echo -n "Select or pass to shell: "
read -r PROFILE_SELECTION
if [ "$PROFILE_SELECTION" -eq 1 ]; then
	exec startx -- "vt$XDG_VTNR"
elif [ "$PROFILE_SELECTION" -eq 2 ]; then
	exec sway
fi
unset PROFILE_SELECTION

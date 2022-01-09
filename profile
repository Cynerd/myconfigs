# First global user configuration
export PATH="$HOME/.local/bin:$PATH"
export EDITOR=vim

# ct-ng configuration
export CT_PREFIX_DIR='~/.local/${CT_TARGET}'
export CT_LOCAL_TARBALLS_DIR="~/src/ct-ng"

# Python caching
export PYTHONPYCACHEPREFIX="$HOME/.cache/pycache"

# Nix
[ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ] && \
	. "$HOME/.nix-profile/etc/profile.d/nix.sh" # added by Nix installer


# Rest of the profile run only if login is from linux console
[[ "$(tty)" != /dev/tty* ]] && return

# Start music player daemon
pgrep mpd >/dev/null || mpd ~/.config/mpd/mpd.conf
# Start ssh-agent
eval "$(ssh-agent -s)"

# And if we are on first terminal also automatically start x server
if [ "$(tty)" = "/dev/tty1" ]; then
	PROFILE_SELECTION=1
else
	echo
	echo "(1) sway"
	echo "(2) i3"
	echo -n "Select or pass to shell: "
	read -r PROFILE_SELECTION
fi
if [ "$PROFILE_SELECTION" -eq 1 ]; then
	exec startsway
elif [ "$PROFILE_SELECTION" -eq 2 ]; then
	exec startx -- "vt$XDG_VTNR"
fi
unset PROFILE_SELECTION

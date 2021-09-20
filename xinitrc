xrdb -merge -I$HOME ~/.Xresources
setxkbmap -option caps:escape
setxkbmap -option compose:menu
numlockx
xset -b # disable beeping

# Use GTK theme for QT applications
export QT_QPA_PLATFORMTHEME=gtk2
export QT_STYLE_OVERRIDE='gtk2'
# use IBus for keyboard inputs
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
# Fix fullscreen game offscreen
export SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS=0
# To fix missing textures on intel
export force_s3tc_enable=true
# Fix firefox touchscreen gestures
export MOZ_USE_XINPUT2=1

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
	for f in /etc/X11/xinit/xinitrc.d/?* ; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi


autorandr --change

exec i3

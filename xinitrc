xrdb -merge -I$HOME ~/.Xresources
setxkbmap -option caps:escape
setxkbmap -option compose:menu
numlockx
xset -b # disable beeping

export QT_QPA_PLATFORMTHEME=gtk2
export QT_STYLE_OVERRIDE='gtk2'
export GTK_IM_MODULE=xim
# Fix fullscreen game offscreen
export SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS=0

mxrandr
start-pulseaudio-x11

exec ck-launch-session dbus-launch --sh-syntax --exit-with-session i3

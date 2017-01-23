xrdb -merge -I$HOME ~/.Xresources
setxkbmap -option caps:escape
setxkbmap -option compose:menu
numlockx
xset -b # disable beeping

export QT_STYLE_OVERRIDE='gtk2'
export GTK_IM_MODULE=xim
# Fix fullscreen game offscreen
export SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS=0

mxrandr
start-pulseaudio-x11

#exec i3 -d all -V >> ~/i3log-$(date +'%F-%k-%M-%S') 2>&1
exec ck-launch-session dbus-launch --sh-syntax --exit-with-session i3
#exec i3 --shmlog-size=26214400

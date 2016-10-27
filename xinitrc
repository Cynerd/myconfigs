xrdb -merge -I$HOME ~/.Xresources
setxkbmap -option caps:escape
setxkbmap -option compose:menu
numlockx

export QT_STYLE_OVERRIDE='gtk2'
export STEAM_RUNTIME=0
export GTK_IM_MODULE=xim

mxrandr
start-pulseaudio-x11

#exec i3 -d all -V >> ~/i3log-$(date +'%F-%k-%M-%S') 2>&1
exec ck-launch-session dbus-launch --sh-syntax --exit-with-session i3
#exec i3 --shmlog-size=26214400

xrdb -merge -I$HOME ~/.Xresources
setxkbmap -option caps:escape

export QT_STYLE_OVERRIDE='gtk2'

#srandrd ~/.bin/mxrandr
mxrandr

#exec i3 -d all -V >> ~/i3log-$(date +'%F-%k-%M-%S') 2>&1
exec i3
#exec i3 --shmlog-size=26214400

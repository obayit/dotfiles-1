#!/bin/sh

# arch defaults {{{1
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi
# }}}

# keyboard {{{
export GTK_IM_MODULE=xim
#export XMODIFIERS=@im=xim
export QT_IM_MODULE=xim

setxkbmap -layout us,ru -option grp:caps_toggle,compose:prsc
xbindkeys
# }}}

# desktop components {{{
nm-applet &
xss-lock -l lock-script.sh &
# }}}

# wm {{{
# compose
picom -i 1 -m 1 -e 1 -b --vsync
exec i3
# }}}

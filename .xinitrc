#!/bin/sh
#
# ~/.xinitrc
#

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# screen powersave
xset +dpms
xset dpms 0 0 300

#calibrate display
xcalib ~/.dotfiles/colorprofile.icc

# keyboard backlight
kbdlight off

#fonts
xset +fp /usr/share/fonts/misc/
xset +fp /usr/share/fonts/TTF/
xset +fp /usr/share/fonts/OTF/
xset +fp /usr/share/fonts/local/
xset +fp /home/godo/.local/share/fonts/
xset +fp /home/godo/.local/share/fonts/TTF
xset fp rehash

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# wallpaper
nitrogen --restore &

# mpd
mpd &

# mouse
xsetroot -cursor_name left_ptr
unclutter -noevents &

#compositing
compton -b
export _JAVA_AWT_WM_NONREPARENTING=1

# WM
sxhkd &
exec bspwm

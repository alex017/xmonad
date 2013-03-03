#!/bin/bash

## GNOME PolicyKit and Keyring
eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg) &

nitrogen --restore &

xsetroot -cursor_name left_ptr

(pidof thunar || thunar --daemon &) &

(pidof xscreensaver || xscreensaver -no-splash &) &

(pidof trayer || trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 12 --height 20 --alpha 0 --transparent true --tint 0x000000 &) &

(pidof clipit || (sleep 1.0s; clipit &)) &

#(pidof pnmixer || (sleep 1.0s; pnmixer &)) &

(pidof xfce4-power-manager || (sleep 1.0s; xfce4-power-manager &)) &

(pidof nm-applet || (sleep 1.0s; nm-applet &)) &

(pidof xxkb || (sleep 1.5s; xxkb &)) &

exit 0

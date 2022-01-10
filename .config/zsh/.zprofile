# automatically start qtile
if [[ "$(tty)" = "/dev/tty1" ]]; then
  pgrep qtile || startx
fi

# mount google drive if it's not mounted
mount -l | grep google || google-drive-ocamlfuse /home/juuso/google-drive

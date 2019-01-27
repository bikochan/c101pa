if [ -s ~/.Xmodmap ]; then
   xmodmap ~/.Xmodmap
fi
exec /usr/bin/i3

#!/bin/sh

#Somnio script to quickly terminate itself and subprocesses

kill -TERM -$(pgrep -o Somnio.sh) && kill -TERM -$(pgrep -o levels.sh) && kill -TERM -$(pgrep -o radio.sh) && kill -TERM -$(pgrep -o nowplaying.py)

return
exit


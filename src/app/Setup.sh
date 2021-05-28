#!/bin/bash

run_all () {
  export LANG="ja_JP.UTF-8";
  export LANGAGE="ja_JP";
  wine=/usr/bin/wine;
  wineboot -i;
  wineserver -w;
  $wine /outside/th06/Touhou06.exe;
  cd /app/touhouML/; 
  cargo run;
}


# Setup XVFB
XVFB="/usr/bin/Xvfb";
XVFBARGS="$DISPLAY -screen 0 1024x768x24  -ac +extension GLX +render -noreset" ;
PIDFILE="/var/run/xvfb.pid";
echo "Starting virtual X frame buffer: $XVFB";
start-stop-daemon --start --quiet --pidfile $PIDFILE --make-pidfile --background --exec $XVFB -- $XVFBARGS;
xvinfo $Display;

# Run code on desktop
xvfb_run='/usr/bin/xvfb-run -e /dev/stdout';

$xvfb_run -a bash -c "declare -f run_all; run_all"

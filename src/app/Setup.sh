#!/bin/bash

DISPLAY=:99;

run_all () {
  xvinfo $Display;
  export LANG="ja_JP.UTF-8";
  export LANGAGE="ja_JP";
  wine=/usr/bin/wine;
  cd /outside/th06;
  $wine Touhou06_jp.exe & true;
  # wait for wine to install the prefix
  sleep 40;
  # Say Yes to installing wine Dependencies
  for num in {0..1..1}
  do 
    import -window root "/outside/screenshot-$num.png";
    xdotool key Return;
    sleep 40;
  done;
  # RUN AI
  cd /app/touhouML/; 
  cargo run;
}


# Setup XVFB
XVFB="/usr/bin/Xvfb";
XVFBARGS="$DISPLAY -screen 0 1024x768x24  -ac +extension GLX +render -noreset" ;
PIDFILE="/var/run/xvfb.pid";
echo "Starting virtual X frame buffer: $XVFB";
start-stop-daemon --start --quiet --pidfile $PIDFILE --make-pidfile --background --exec $XVFB -- $XVFBARGS;

# Run code on desktop
xvfb_run='/usr/bin/xvfb-run -e /dev/stdout';
FUNC=$(declare -f run_all);
$xvfb_run -a bash -c "$FUNC; run_all"

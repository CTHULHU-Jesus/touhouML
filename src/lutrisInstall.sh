#!/bin/bash

DISPLAY=:99;

run_all () {
  /usr/sbin/sshd start;
  export LANG="ja_JP.UTF-8";
  export LANGAGE="ja_JP";
  xhost +;
  xvinfo $Display;
  lutris=/usr/games/lutris
  $lutris lutris:install/touhou-6-embodiment-of-scarle-cd-with-thcrap-and-v & true;
  # wait for lutris to install the prefix
  sleep 15;
  # Click on pixel 315,95 with M1
  # to run lutris as root
  import -window root "/outside/Lut-screenshot-0.png";
  xdotool mousemove 315 95;
  xdotool click 1;
  echo Step 0;
  # Wait for lutris to get up and running
  sleep 240;
  # Click on pixel 930 470 with M1
  # to install TH06
  import -window root "/outside/Lut-screenshot-1.png";
  xdotool mousemove 930 470;
  xdotool click 1;
  echo Step 1;
  sleep 2;
  # Click on pixel 948 625 with M1
  # to select install directory
  import -window root "/outside/Lut-screenshot-2.png";
  xdotool mousemove 948 625;
  xdotool click 1;
  echo Step 2;
  sleep 60;
  # Click on pixel 948 625 with M1
  # to install files
  import -window root "/outside/Lut-screenshot-3.png";
  xdotool mousemove 948 625;
  xdotool click 1;
  echo Step 3;
  sleep 15;
  # Click on pixel 810 568
  # to install from mounted game disk
  import -window root "/outside/Lut-screenshot-4.png";
  xdotool mousemove 810 568;
  xdotool --repeat 2 click 1;
  echo Step 4;
  # Say Yes to installing wine Dependencies
  for num in {5..15..1}
  do 
    sleep 10;
    import -window root "/outside/Lut-screenshot-$num.png";
    echo Start $num
  done;
}


# Setup XVFB
XVFB="/usr/bin/Xvfb";
XVFBARGS="$DISPLAY -screen 0 1024x768x24  -ac +extension GLX +render -noreset -l" ;
PIDFILE="/var/run/xvfb.pid";
echo "Starting virtual X frame buffer: $XVFB";
start-stop-daemon --start --quiet --pidfile $PIDFILE --make-pidfile --background --exec $XVFB -- $XVFBARGS;


# Run code on desktop
xvfb_run='/usr/bin/xvfb-run -e /dev/stdout';
FUNC=$(declare -f run_all);
$xvfb_run -a bash -c "$FUNC; run_all"


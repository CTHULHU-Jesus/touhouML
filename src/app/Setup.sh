#!/bin/bash

# xvfb setup
#!/bin/sh

# Setup XVFB
export DISPLAY=:0;
XVFB=/usr/bin/Xvfb;
XVFBARGS="$DISPLAY -screen 0 1024x768x24  -ac +extension GLX +render -noreset -nolisten tcp";
PIDFILE=/var/run/xvfb.pid;
echo "Starting virtual X frame buffer: Xvfb";
start-stop-daemon --start --quiet --pidfile $PIDFILE --make-pidfile --background --exec $XVFB -- $XVFBARGS;
echo "Display: $DISPLAY";
xvinfo;

# Run Code
wine=/usr/bin/wine;
xvfb_run=/usr/bin/xvfb-run;
Touhou_exec="sudo $xvfb_run $wine /outside/th06/Touhou06.exe";

echo "runnign $Touhou_exec";
$xvfb_run $wine /outside/th06/Touhou06.exe & true;

cd /app/touhouML/; 
cargo run;

#!/bin/bash

# INSTALL THCRAP
# Stole from https://gitlab.com/-/snippets/2028159
THCRAPPATH="";
PATCHES=$(ls -I config.js -I games.js "$THCRAPPATH/.thcrap/config" 2> /dev/null);
wget -q -c -P "/tmp" "https://github.com/thpatch/thcrap/releases/latest/download/thcrap.zip"; 
mkdir -p "$THCRAPPATH/.thcrap"; 
if [ -d "$THCRAPPATH/.thcrap/bin" ]; then
    printf "\033[1mcleanup\033[0m\n"; 
    rm -R "$THCRAPPATH/.thcrap/bin";
    rm "$THCRAPPATH/.thcrap/"*.dll "$THCRAPPATH/.thcrap/"*.exe;
fi;
unzip -o "/tmp/thcrap.zip" -d "$THCRAPPATH/.thcrap" > /dev/null;
rm "/tmp/thcrap.zip";
ln -fs "$THCRAPPATH/.thcrap/bin/"*.dll "$THCRAPPATH/.thcrap";
printf "\033[1minstallation complete\033[0m\n";

# INSTALL WINE DEPENDENCIES
: <<'END'
# Setup XVFB
XVFB="/usr/bin/Xvfb";
XVFBARGS="$DISPLAY -screen 0 1024x768x24  -ac +extension GLX +render -noreset" ;
PIDFILE="/var/run/xvfb.pid";
echo "Starting virtual X frame buffer: $XVFB";
start-stop-daemon --start --quiet --pidfile $PIDFILE --make-pidfile --background --exec $XVFB -- $XVFBARGS;

wineInstall () {
  glxinfo;
  winetricks -q allfonts;
}
FUNC=$(declare -f wineInstall);
xvfb_run='/usr/bin/xvfb-run -e /dev/stdout';
$xvfb_run bash -c "$FUNC; wineInstall";
END

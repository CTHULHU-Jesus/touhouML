FROM ubuntu:focal
# Open required ports
EXPOSE 8080
EXPOSE 8443
# Set Display
ENV DISPLAY :0.0

# Install dependensies
RUN apt-get update  -qq
RUN dpkg --add-architecture i386
RUN apt-get update  -qq
Run apt-get install -qq wget gpg
RUN apt-get install -qq apt-utils software-properties-common 
# Install lutris to run Touhou 6
RUN add-apt-repository ppa:lutris-team/lutris
RUN apt-get update -qq
RUN DEBIAN_FRONTEND=noninteractive apt-get install -qq lutris
# # WINE INSTALL
# RUN wget -nc https://dl.winehq.org/wine-builds/winehq.key
# RUN gpg -o /etc/apt/trusted.gpg.d/winehq.key.gpg --dearmor winehq.key
# RUN add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'
# RUN apt-get update -y
# RUN apt-get install -y --install-recommends winehq-stable winetricks
# Non-Wine Dependencies
RUN apt-get install -qq mono-complete
RUN apt-get install -qq rustc cargo 
RUN apt-get install -qq xvfb
RUN apt-get install -qq libxdo-dev xdotool
RUN apt-get install -qq libxcb-randr0-dev
RUN apt-get install -qq libxcb-shm0-dev
RUN apt-get install -qq pkg-config libx11-dev
RUN apt-get install -qq x11-utils  x11-xserver-utils
RUN apt-get install -qq unzip
RUN apt-get install -qq imagemagick
RUN apt-get install -qq fuseiso
RUN apt-get install -qq language-pack-ja
RUN apt-get install -qq xorriso
RUN apt-get install -qq openssh-server
# RUN apt-get install -y mesa-utils
RUN apt-get upgrade  -y

# # WINEPREFIX SETUP
# # Stole from https://gitlab.com/-/snippets/2028159
# ENV WINEPREFIX "/.th_wine"
# ENV WINEARCH win32
# RUN mkdir -m=777 $WINEPREFIX
# ADD WineSetup.sh /tmp/WineSetup.sh
# RUN /tmp/WineSetup.sh

# ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ 
# Install touhou 6: Embodyment of Scarlit Devil 
# ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ 
ADD th06.iso /tmp/th06.iso
RUN mkdir /iso
RUN osirrox -indev /tmp/th06.iso -extract / /iso
ADD lutrisInstall.sh /tmp/lutrisInstall.sh
EXPOSE 22
RUN echo " \
Include /etc/ssh/ssh_config.d/*.conf \n\
Host * \n\
    ForwardX11 yes    \n\
    SendEnv LANG LC_*  \n\
    HashKnownHosts yes  \n\
    X11DisplayOffset 10  \n\
    ForwardX11Trusted yes \n\
    GSSAPIAuthentication yes" > /etc/ssh/ssh_config
CMD /tmp/lutrisInstall.sh | tee /outside/TH6intstall.log 2>&1

# 
# # Install large rust depencencies to speed 
# RUN cargo install cargo-chef --version 0.1.20
# RUN mkdir -p /app/touhouML/target
# ADD recipe.json /tmp/recipe.json
# RUN cd /app/touhouML/; cargo chef cook --recipe-path /tmp/recipe.json
# RUN cd /app/touhouML/; cargo chef cook --release --recipe-path /tmp/recipe.json
# 
# # Setup App       
# ADD app/ /app     
# 
# # Run Code
# CMD  /app/Setup.sh > /outside/rustinfo.log 2>&1

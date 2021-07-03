FROM ubuntu:focal
# Open required ports
EXPOSE 8080
EXPOSE 8443
# Set ENV
ENV DEBIAN_FRONTEND noninteractive

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
# WINE INSTALL
RUN cd /tmp && wget -nc https://dl.winehq.org/wine-builds/winehq.key
RUN apt-key add /tmp/winehq.key
RUN add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'
RUN apt-get update -y
RUN apt-get install -y --install-recommends winehq-stable
# Non-Wine Dependencies
RUN apt-get install -qq mono-complete
RUN apt-get install -qq language-pack-ja
RUN apt-get install -qq xorriso

# ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ 
# Install touhou 6: Embodyment of Scarlit Devil 
# ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ 
ENV LANG    ja_JP.UTF-8
ENV LANGAGE ja_JP

ADD th06.iso /tmp/th06.iso
RUN mkdir /iso
RUN osirrox -indev /tmp/th06.iso -extract / /iso
ADD lutrisInstall.sh /tmp/lutrisInstall.sh

RUN useradd -m user
USER user
ENV USER=user
CMD /usr/games/lutris lutris:install/touhou-6-embodiment-of-scarle-cd-with-thcrap-and-v | tee /outside/TH6intstall.log 2>&1

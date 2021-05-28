FROM ubuntu:focal
# Open required ports
EXPOSE 8080
EXPOSE 8443
# Set Display
ENV DISPLAY :0.0

# Install dependensies
RUN apt-get update  -y
RUN dpkg --add-architecture i386
RUN apt-get update  -y
# WINE INSTALL

# Stole from https://github.com/tianon/dockerfiles/blob/master/wine/Dockerfile
RUN set -eux; \
	apt-get install -y --no-install-recommends apt-transport-https ca-certificates; \
	savedAptMark="$(apt-mark showmanual)"; \
	apt-get install -y --no-install-recommends gnupg dirmngr; \
	rm -rf /var/lib/apt/lists/*; \
	export GNUPGHOME="$(mktemp -d)"; \
	gpg --batch --keyserver ha.pool.sks-keyservers.net --recv-keys D43F640145369C51D786DDEA76F1A20FF987672F; \
	gpg --batch --export --armor D43F640145369C51D786DDEA76F1A20FF987672F > \
    /etc/apt/trusted.gpg.d/winehq.gpg.asc; \
	gpgconf --kill all; \
	rm -rf "$GNUPGHOME"; \
	apt-key list | grep 'WineHQ'; \
	\
	apt-mark auto '.*' > /dev/null; \
	apt-mark manual $savedAptMark > /dev/null; \
	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
	\
	suite="$(awk '$1 == "deb" { print $3; exit }' /etc/apt/sources.list)"; \
	echo "deb https://dl.winehq.org/wine-builds/ubuntu $suite main" > /etc/apt/sources.list.d/winehq.list

# https://dl.winehq.org/wine-builds/debian/dists/buster/main/binary-amd64/?C=N;O=D
# https://www.winehq.org/news/
ENV WINE_VERSION 5.10

RUN set -eux; \
	{ \
		echo 'Package: *wine* *wine*:i386'; \
		echo "Pin: version $WINE_VERSION~*"; \
		echo 'Pin-Priority: 1001'; \
	} > /etc/apt/preferences.d/winehq.pref; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		"winehq-staging=$WINE_VERSION~*" ;\
	rm -rf /var/lib/apt/lists/*

RUN wget -nc https://dl.winehq.org/wine-builds/winehq.key
RUN apt-key add winehq.key
RUN add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ $suite main'
RUN apt-get update
RUN apt-get install -y winehq-stable winetricks winbind
# Non-Wine Dependencies
RUN apt-get update  -y
RUN apt-get install -y mono-complete
RUN apt-get install -y apt-utils
RUN apt-get install -y rustc cargo 
RUN apt-get install -y xvfb
RUN apt-get install -y libxdo-dev
RUN apt-get install -y libxcb-randr0-dev
RUN apt-get install -y libxcb-shm0-dev
RUN apt-get install -y pkg-config libx11-dev
RUN apt-get install -y x11-utils  x11-xserver-utils
Run apt-get install -y wget

# WINEPREFIX SETUP
# Stole from https://gitlab.com/-/snippets/2028159
ENV WINEPREFIX "/.th_wine"
ENV WINEARCH win32
RUN mkdir -m=777 $WINEPREFIX
ADD WineSetup.sh /tmp/WineSetup.sh
RUN /tmp/WineSetup.sh

# ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ 
# Install touhou 6: Embodyment of Scarlit Devil 
# ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ 
# Must be done manualy because of Leagal reasons

# Install large rust depencencies to speed 
RUN cargo install cargo-chef --version 0.1.20
RUN mkdir -p /app/touhouML/target
ADD recipe.json /tmp/recipe.json
RUN cd /app/touhouML/; cargo chef cook --recipe-path /tmp/recipe.json
RUN cd /app/touhouML/; cargo chef cook --release --recipe-path /tmp/recipe.json

# Setup App       
ADD app/ /app     

# Run Code
CMD  /app/Setup.sh > /outside/rustinfo.log 2>&1

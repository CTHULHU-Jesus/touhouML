FROM touhou-ml_base:latest

USER root
ENV LANG    en_US.UTF-8
ENV LANGAGE en_US


# Install rust utilities and dependecies
RUN apt-get install -qq rustc cargo 
RUN apt-get install -qq xvfb
RUN apt-get install -qq libxdo-dev xdotool
RUN apt-get install -qq libxcb-randr0-dev
RUN apt-get install -qq libxcb-shm0-dev
RUN apt-get install -qq pkg-config libx11-dev
RUN apt-get install -qq x11-utils  x11-xserver-utils
RUN apt-get install -qq x11-apps
RUN apt-get install -qq imagemagick

# Install large rust depencencies to speed 
RUN cargo install cargo-chef --version 0.1.20
RUN mkdir -p /app/touhouML/target
ADD recipe.json /tmp/recipe.json
ADD fixedConfig.txt /home/user/Games/touhou-06-embodiment-of-scarlet-devil/pfx/drive_c/Program Files/touhou6/custom.txt
RUN cd /app/touhouML/; cargo chef cook --recipe-path /tmp/recipe.json
RUN cd /app/touhouML/; cargo chef cook --release --recipe-path /tmp/recipe.json

# Setup App       
ADD app/ /app     

# Run Code
ENV USER user
CMD  /app/Setup.sh > /outside/rustinfo.log 2>&1

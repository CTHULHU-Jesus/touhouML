FROM ubuntu:focal
# Open required ports
EXPOSE 8080
EXPOSE 8443
# Install dependensies
RUN dpkg --add-architecture i386
RUN apt-get update  -y
RUN apt-get install -y rustc cargo 
RUN apt-get install -y wine-stable
RUN apt-get install -y xvfb
RUN apt-get install -y libxdo-dev
RUN apt-get install -y libxcb-randr0-dev
RUN apt-get install -y libxcb-shm0-dev
RUN apt-get install -y pkg-config libx11-dev
RUN apt-get install -y x11-utils  x11-xserver-utils


# ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ 
# Install touhou 6: Embodyment of Scarlit Devil 
# ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ ⑨ 
# Must be done manualy because of Leagal

# Install large rust depencencies to speed 
RUN cargo install cargo-chef --version 0.1.20
RUN mkdir -p /app/touhouML/target
ADD recipe.json /tmp/recipe.json
RUN cd /app/touhouML/; cargo chef cook --recipe-path /tmp/recipe.json
RUN cd /app/touhouML/; cargo chef cook --release --recipe-path /tmp/recipe.json
# up compilation time in the image
# RUN cargo install enigo  --version "0.0.14"
# RUN cargo install scrap  --version "0.5"
# RUN cargo install anyhow --version "^1.0"
# RUN cargo install image  --version "^0.23"

# Setup App       
ADD app/ /app     

# Run Code
CMD  /app/Setup.sh > /outside/rustinfo.log 2>&1

FROM ubuntu:20.04

# Minecraft version to install
ARG VERSION=1.0.0.0

# Setup requirements
RUN apt-get update
RUN apt-get install -y unzip curl libcurl4 libssl1.1 gettext-base
RUN curl -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/97.0.4692.99 Safari/537.36 OPR/83.0.4254.70" https://www.minecraft.net/bedrockdedicatedserver/bin-linux/bedrock-server-${VERSION}.zip --output bedrock-server.zip
RUN unzip bedrock-server.zip -d bedrock-server
RUN rm bedrock-server.zip

# Copy template files
COPY config/server.properties /bedrock-server/server.properties.template
COPY start.sh /bedrock-server/
RUN chmod +x /bedrock-server/start.sh /bedrock-server/bedrock_server

# Setup settings
ENV MC_NAME DockerMinecraftServer
ENV MC_GAMEMODE survival
ENV MC_DIFFICULTY easy
ENV MC_ALLOWCHEATS false
ENV MC_MAXPLAYERS 10
ENV MC_ONLINEMODE true
ENV MC_WHITELIST false
ENV MC_PORT 19132
ENV MC_PORTV6 19133
ENV MC_VIEWDISTANCE 32
ENV MC_TICKDISTANCE 4
ENV MC_PLAYERIDLETIMEOUT 30
ENV MC_MAXTHREADS 8
ENV MC_LEVELNAME Bedrock level
# Seed is default empty
#ENV MC_LEVELSEED 
ENV MC_DEFAULTPLAYERPERMISSIONLEVEL member
ENV MC_TEXTUREPACKREQUIRED false

EXPOSE 19132/udp
EXPOSE 19132/tcp

# Start server
WORKDIR /bedrock-server
ENV LD_LIBRARY_PATH=.
CMD ./start.sh

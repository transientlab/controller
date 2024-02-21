# parent image
FROM debian:latest

SHELL ["/bin/bash", "-c"]

# set the default user
USER root

# ENV name=value

COPY server/ /etc/sc  

WORKDIR /etc/sc/

RUN apt-get update -qy
RUN apt-get upgrade -qy
RUN apt-get install npm -qy
RUN npm install express
RUN npm install serve-favicon
RUN apt-get install netcat-traditional -qy

EXPOSE 3000

CMD node server.js

# COPY <src> <dst>    
# ADD [--chown=<user>:<group>] [--chmod=<perms>] [--checksum=<checksum>] <src>... <dest>
# ADD [--chown=<user>:<group>] [--chmod=<perms>] ["<src>",... "<dest>"]

# LABEL

# STOPSIGNAL



# VOLUME

# ONBUILD 
 
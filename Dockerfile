FROM ubuntu
MAINTAINER obed.n.munoz@gmail.com

# Install TexLive
ENV DEBIAN_FRONTEND noninteractive
RUN apt update -y
RUN apt install texlive-full -y

# Default command at container start
RUN mkdir -p /mnt/aux/includes
ADD tex-utils.sh /usr/bin/tex

WORKDIR "/mnt"

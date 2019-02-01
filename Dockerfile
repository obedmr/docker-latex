FROM alpine
MAINTAINER obed.n.munoz@gmail.com

# Install TexLive
RUN apk add --update --progress texlive-full

# Default command at container start
RUN mkdir -p /mnt/aux/includes
ADD tex-utils.sh /usr/bin/tex

WORKDIR "/mnt"

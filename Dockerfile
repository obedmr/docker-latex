FROM obedmr/archlinux
MAINTAINER obed.n.munoz@gmail.com

# Install TexLive
RUN pacman -Sy --noconfirm texlive-most
USER yaourt
RUN yaourt.sh texlive-gantt
USER root
RUN pacman -U --noconfirm /tmp/package.tar.xz
RUN pacman -Sc --noconfirm

# Default command at container start
RUN mkdir -p /mnt/aux/includes
ADD tex-utils.sh /usr/bin/tex

WORKDIR "/mnt"
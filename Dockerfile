FROM base/archlinux
MAINTAINER obed.n.munoz@gmail.com

# Update all
RUN pacman -Sc --noconfirm
RUN pacman-key --refresh-keys 
RUN pacman -Syu --noconfirm

# Add AUR Repository
ADD repo.fr /tmp/repo.fr
RUN cat /tmp/repo.fr >> /etc/pacman.conf
RUN rm /tmp/repo.fr
RUN pacman-db-upgrade
RUN pacman -Syu --noconfirm yaourt
RUN useradd yaourt
RUN echo -e "secure\nsecure" | passwd yaourt
RUN echo 'yaourt ALL=(ALL) NOPASSWD: ALL >> /etc/sudoers'

# Install TexLive
RUN pacman -Sy --noconfirm texlive-most
RUN pacman -Sy --noconfirm base-devel
USER yaourt
RUN mkdir -p /tmp/yaourt/ ; chown yaourt /tmp/yaourt
USER yaourt
RUN cd /tmp/yaourt ; yaourt --getpkgbuild aur/texlive-gantt ; cd texlive-gantt ; makepkg ; ls -la
USER root
RUN pacman -U --noconfirm /tmp/yaourt/texlive-gantt/texlive-gantt*.pkg.tar.xz

# Default command at container start
RUN mkdir -p /mnt/aux/includes
ADD tex-utils.sh /usr/bin/tex

WORKDIR "/mnt"
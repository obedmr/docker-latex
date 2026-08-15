FROM python:3.12-slim-bookworm
LABEL maintainer="obed.n.munoz@gmail.com"

ARG DEBIAN_FRONTEND=noninteractive

# Runtime tools for TinyTeX plus small project helpers.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        fontconfig \
        gawk \
        make \
        perl \
        xz-utils \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL "https://yihui.org/tinytex/install-bin-unix.sh" | sh \
    && mv /root/.TinyTeX /opt/TinyTeX \
    && TEXBIN="$(find /opt/TinyTeX/bin -mindepth 1 -maxdepth 1 -type d | head -n1)" \
    && ln -s "$TEXBIN" /opt/tinytex-bin

ENV PATH="/opt/tinytex-bin:${PATH}"
ENV TEXMFVAR="/tmp/texmf-var"
ENV TEXMFCONFIG="/tmp/texmf-config"
ENV TEXMFHOME="/tmp/texmf-home"

COPY tlmgr-packages.txt /tmp/tlmgr-packages.txt

# Curated package set from discipulado-epc1 and iblv/cursos. Avoid texlive-full.
RUN tlmgr option docfiles 0 \
    && tlmgr option srcfiles 0 \
    && tlmgr update --self \
    && sed -e 's/#.*//' -e '/^[[:space:]]*$/d' /tmp/tlmgr-packages.txt | xargs -r tlmgr install \
    && mktexlsr \
    && fmtutil-sys --all \
    && rm -rf /opt/TinyTeX/tlpkg/backups/* /tmp/*

RUN python -m pip install --no-cache-dir PyYAML

RUN mkdir -p /mnt/aux/includes
COPY tex-utils.sh /usr/bin/tex

WORKDIR "/mnt"

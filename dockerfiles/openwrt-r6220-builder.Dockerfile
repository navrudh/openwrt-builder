FROM alpine:3.12.1

ARG USER=navrudh
ENV HOME /home/$USER

RUN apk add --no-cache asciidoc bash bc binutils bzip2 cdrkit coreutils diffutils \
    findutils flex g++ gawk gcc gettext git grep intltool libxslt \
    linux-headers make ncurses-dev patch perl python2-dev python3-dev \
    rsync tar unzip util-linux wget zlib-dev \
    && adduser -D $USER

USER root
WORKDIR $HOME

RUN git config --global user.name "Dhruvan Ganesh" && git config --global user.email "navrudh@docker"

ARG BUILDER=builder-url.tar.xz
RUN echo "Downloading from $BUILDER" \
    && mkdir $HOME/builder && wget -qO- $BUILDER | tar -xJC $HOME/builder

RUN mkdir $HOME/files
COPY files $HOME/files

RUN echo "Building Image" \
    && cd builder/* \
    && mv $HOME/files . \
    && echo "Src directory: $(pwd)" \
    && make image PROFILE=r6220 \
                  PACKAGES="announce xl2tpd vsftpd luci luci-app-hd-idle luci-app-minidlna dnsmasq luci-app-https-dns-proxy" \
                  FILES=files/

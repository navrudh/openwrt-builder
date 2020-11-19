FROM ubuntu:xenial

USER root

RUN apt-get update \
    && apt-get install -y sudo subversion g++ zlib1g-dev build-essential git \
    python python3 python3-distutils-extra libncurses5-dev gawk gettext unzip \
    file libssl-dev wget libelf-dev ecj fastjar java-propose-classpath \
    rsync swig time python3-setuptools libncursesw5-dev ccache xsltproc
    
RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo

USER docker	

RUN git config --global user.name "Dhruvan Ganesh" && git config --global user.email "navrudh@docker"

CMD ["/bin/bash"]


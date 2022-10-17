# Builds a Docker image with Ubuntu 22.04, GCC-11.2, clang, vscode, LAPACK, ddd,
# and valgrind for "AMS 526: Numerical Analysis I/Numerical Linear Algebra"
# at Stony Brook University
#
# Authors:
# Xiangmin Jiao <xmjiao@gmail.com>

FROM x11vnc/vscode-desktop:latest
LABEL maintainer "Xiangmin Jiao <xmjiao@gmail.com>"

USER root
WORKDIR /tmp

ADD image/home $DOCKER_HOME/

# Install system packages
RUN apt update && \
    apt upgrade -y && \
    apt install -y --no-install-recommends \
        doxygen \
        git \
        gdb \
        ddd \
        valgrind \
        electric-fence \
        libeigen3-dev \
        libopenblas-dev \
        liblapacke-dev \
        libopenmpi-dev \
        openmpi-bin \
        libomp-dev \
        meld \
        clang \
        clang-format \
        swig3.0 \
        python3 \
        python3-dev \
        libnss3 \
        libdpkg-perl \
        fonts-dejavu-extra \
        debhelper \
        devscripts \
        gnupg \
        && \
    apt clean -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

########################################################
# Customization for user
########################################################
ENV GIT_EDITOR=vim EDITOR=code
COPY WELCOME $DOCKER_HOME/WELCOME

RUN echo "export OMP_NUM_THREADS=\$(nproc)" >> $DOCKER_HOME/.profile && \
    chown -R $DOCKER_USER:$DOCKER_GROUP $DOCKER_HOME

WORKDIR $DOCKER_HOME

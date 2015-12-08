FROM ubuntu:vivid

ENV TSUNG_WORKSPACE=$HOME/.tsung
ENV TSUNG_CONFIG_FILE=tsung.xml

RUN apt-get update && \
    apt-get -y install wget \
    build-essential debhelper \
    erlang-nox erlang-dev \
    python-matplotlib gnuplot \
    libtemplate-perl \
    openssh-client openssh-server

RUN wget https://github.com/processone/tsung/archive/v1.6.0.tar.gz && \
    tar -xvzf v1.6.0.tar.gz && \
    cd tsung-1.6.0 && ./configure && make && make install

RUN ssh-keygen -t rsa -b 4096 -N "" -f $HOME/.ssh/id_rsa && \
    cat $HOME/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys && \
    echo "Host localhost" >> $HOME/.ssh/config && \
    echo "   StrictHostKeyChecking no" >> $HOME/.ssh/config && \
    echo "   UserKnownHostsFile=/dev/null" >> $HOME/.ssh/config

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

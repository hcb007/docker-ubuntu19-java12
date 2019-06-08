# Base docker image for Ubuntu 19.04 to run applications with Java 12
FROM ubuntu:19.04

LABEL maintainer="Mariana de Azevedo Santos <mariana@bsi.ufla.br>"

ENV USER=java12
ENV GUID=1000

ENV LANG=pt_BR.UTF-8
ENV JAVA_HOME /usr/java/oracle-java12
ENV PATH $JAVA_HOME/bin:$PATH

RUN apt-get update \
    && apt-get -y install sudo software-properties-common --no-install-recommends \
    && add-apt-repository ppa:linuxuprising/java \
    && echo "oracle-java12-installer shared/accepted-oracle-license-v1-2 select true" | sudo debconf-set-selections \
    && apt-get install -y oracle-java12-installer --no-install-recommends oracle-java12-set-default \
    && echo "pt_BR.UTF-8 UTF-8" > /etc/locale.gen && locale-gen \
    && mkdir -p /home/${USER} \
    && groupadd -g ${GUID} -r ${USER} \
    && useradd -u ${GUID} -r -g ${USER} -G audio,video ${USER} -d /home/${USER} \
    && chown -R ${GUID}:${GUID} /home/${USER} \
    && mkdir -p /etc/sudoers.d \
    && echo 'java12 ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers \
    && echo 'Defaults !requiretty' >> /etc/sudoers \
    && echo root:java12 | chpasswd \
    && rm -rf /var/lib/apt/lists/*

USER java12

WORKDIR /home/java12/
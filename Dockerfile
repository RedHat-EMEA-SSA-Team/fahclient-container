FROM centos:8
  
MAINTAINER Natale Vinto <nvinto@redhat.com>

ARG FAH_VERSION_MAJOR=7
ARG FAH_VERSION_MINOR=5
ARG FAH_VERSION_PATCH=1
ARG FAH_VERSION_PKG=1
ENV USER=Anonymous
ENV TEAM=0
ENV POWER=full
ENV GPU=false

RUN dnf update -y && rm -rf /var/cache/yum
RUN dnf install -y https://download.foldingathome.org/releases/public/release/fahclient/centos-6.7-64bit/v$FAH_VERSION_MAJOR.$FAH_VERSION_MINOR/fahclient-$FAH_VERSION_MAJOR.$FAH_VERSION_MINOR.$FAH_VERSION_PATCH-$FAH_VERSION_PKG.x86_64.rpm \
    && dnf clean all

RUN chown -R 1001:0 /etc/fahclient && \
    chmod -R g=u /etc/fahclient
    #chown -R 1001:0 /var/lib/fahclient && \
    #chmod -R g=u /var/lib/fahclient

EXPOSE 7396

USER 1001

CMD FAHClient --web-allow=0/0:7396 --allow=0/0:7396 --user=$USER --team=$TEAM --gpu=$GPU --smp=true --power=$POWER --chdir=/tmp

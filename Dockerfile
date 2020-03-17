FROM centos:8
  
MAINTAINER Natale Vinto <nvinto@redhat.com>

ENV FAH_VERSION_MINOR=7.5.1
ENV FAH_VERSION_MAJOR=7.5
ENV USER=Anonymous
ENV TEAM=0
ENV POWER=full
ENV GPU=false

RUN dnf update -y && rm -rf /var/cache/yum
RUN dnf install -y https://download.foldingathome.org/releases/public/release/fahclient/centos-6.7-64bit/v7.5/fahclient-7.5.1-1.x86_64.rpm \
    && dnf clean all

RUN chown -R 1001:0 /etc/fahclient && \
    chmod -R g=u /etc/fahclient
    #chown -R 1001:0 /var/lib/fahclient && \
    #chmod -R g=u /var/lib/fahclient

EXPOSE 7396

USER 1001

CMD FAHClient --web-allow=0/0:7396 --allow=0/0:7396 --user=$USER --team=$TEAM --gpu=$GPU --smp=true --power=$POWER --chdir=/tmp

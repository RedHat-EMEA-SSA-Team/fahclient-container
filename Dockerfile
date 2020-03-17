FROM registry.access.redhat.com/ubi8/ubi-minimal

MAINTAINER Natale Vinto <nvinto@redhat.com>

ENV FAH_VERSION_MINOR=7.5.1
ENV FAH_VERSION_MAJOR=7.5
ENV TEAM=0
ENV POWER=full
ENV GPU=false

RUN microdnf update -y && rm -rf /var/cache/yum
RUN microdnf install -y tar bzip2 && microdnf clean all
RUN mkdir -p /var/lib/fahclient

RUN curl -SL https://download.foldingathome.org/releases/public/release/fahclient/centos-6.7-64bit/v7.5/fahclient_7.5.1-64bit-release.tar.bz2 | tar -xjC /var/lib/fahclient --strip 1

RUN chown -R 1001:0 /var/lib/fahclient && \
    chmod -R g=u /var/lib/fahclient
    
EXPOSE 7396

USER 1001

CMD /var/lib/fahclient/FAHClient --web-allow=0/0:7396 --allow=0/0:7396 --user=Anonymous --team=$TEAM --gpu=$GPU --smp=true --power=$POWER

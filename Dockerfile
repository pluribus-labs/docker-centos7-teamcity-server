# docker run -dt -p 8111:8111 pluribuslabs/centos7-teamcity-server

FROM pluribuslabs/centos7-oracle-jdks-7-8

MAINTAINER Pluribus Labs Docker Dev <docker-dev@pluribuslabs.com>

# TeamCity data stored in a volume to help with container upgrade
VOLUME  ["/data/teamcity"]
ENV TEAMCITY_DATA_PATH /data/teamcity
ENV TEAMCITY_PACKAGE TeamCity-9.1.7.tar.gz
ENV TEAMCITY_DOWNLOAD https://download.jetbrains.com/teamcity

# Download and install TeamCity to /opt
RUN yum -y install tar wget && \
    wget $TEAMCITY_DOWNLOAD/$TEAMCITY_PACKAGE && \
    tar zxf $TEAMCITY_PACKAGE -C /opt && \
    rm -rf $TEAMCITY_PACKAGE

EXPOSE 8111
CMD ["/opt/TeamCity/bin/teamcity-server.sh", "run"]

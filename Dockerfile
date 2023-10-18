FROM ubuntu:22.04
LABEL maintainer="wqf121314@gmail.com"

ARG JMETER_VERSION
ENV JMETER_VERSION ${JMETER_VERSION:-5.6.2}
ENV JMETER_HOME /jmeter/apache-jmeter-$JMETER_VERSION/
ENV PATH $JMETER_HOME/bin:$PATH
ENV TZ=UTC
USER root
# Install pre-requisite
RUN apt-get update && \
    apt-get clean && \
    apt-get -y upgrade && \
    apt-get -y dist-upgrade

# Install dependency package
RUN apt-get -y install openjdk-17-jre && \
    apt-get -y install wget && \
    apt-get -y install unzip && \
    apt-get -y install curl && \
    apt-get -y install vim && \
    apt-get -y install net-tools && \
    apt-get -y install tzdata

# Setting the timezone to UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install jmeter base
RUN mkdir /jmeter
WORKDIR /jmeter

RUN wget https://dlcdn.apache.org//jmeter/binaries/apache-jmeter-$JMETER_VERSION.tgz && \
    tar -xzf apache-jmeter-$JMETER_VERSION.tgz && \
    rm apache-jmeter-$JMETER_VERSION.tgz

RUN mkdir /jmeter-plugins && \
    cd /jmeter-plugins/ && \
    wget https://jmeter-plugins.org/files/JMeterPlugins-ExtrasLibs-1.4.0.zip && \
    unzip -o JMeterPlugins-ExtrasLibs-1.4.0.zip -d /jmeter/apache-jmeter-$JMETER_VERSION

# Configuring the environment
WORKDIR $JMETER_HOME
COPY cases scripts
COPY scripts/run_LoadTest.sh .
COPY config/user.properties bin/user.properties
COPY config/report-template/ bin/report-template/
COPY scripts/install_plugin-manager.sh .
COPY scripts/docker-entrypoint.sh /docker-entrypoint.sh

RUN chmod +x install_plugin-manager.sh run_LoadTest.sh /docker-entrypoint.sh

RUN ./install_plugin-manager.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

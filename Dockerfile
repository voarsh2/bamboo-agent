FROM atlassian/bamboo-agent-base:latest

# Install SonarScanner
USER root

RUN apt-get update -y && \
apt-get install -y wget unzip tar

# Install gnupg
RUN apt-get update -y && \
    apt-get install -y gnupg

RUN curl -sSL https://sonarcloud.io/static/cpp/build-wrapper-linux-x86.zip -o build-wrapper-linux-x86.zip \
    && unzip build-wrapper-linux-x86.zip \
    && rm build-wrapper-linux-x86.zip \
    && mv build-wrapper-linux-x86 /usr/local/bin/



RUN apt-get update -y && \
    apt-get install -y apt-transport-https ca-certificates curl git make


RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
RUN apt-get update -y && \
    apt-get install -y docker-ce

VOLUME /var/run/docker.sock

RUN ${BAMBOO_USER_HOME}/bamboo-update-capability.sh "system.sonarscanner.executable" /usr/local/bin/sonar-scanner
RUN ${BAMBOO_USER_HOME}/bamboo-update-capability.sh "system.docker.executable" /usr/bin/docker

USER bamboo

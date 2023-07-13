FROM atlassian/bamboo-agent-base:latest

# Install SonarScanner
USER root
RUN curl -sSL https://sonarcloud.io/static/cpp/build-wrapper-linux-x86.zip -o build-wrapper-linux-x86.zip \
    && unzip build-wrapper-linux-x86.zip \
    && rm build-wrapper-linux-x86.zip \
    && mv build-wrapper-linux-x86 /usr/local/bin/

RUN apt-get update -y && \
apt-get install -y wget unzip tar

RUN apt-get update -y && \
    apt-get install -y apt-transport-https ca-certificates curl git make

RUN ${BAMBOO_USER_HOME}/bamboo-update-capability.sh "system.sonarscanner.executable" /usr/local/bin/sonar-scanner

USER bamboo

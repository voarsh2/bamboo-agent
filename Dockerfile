FROM atlassian/bamboo-agent-base:latest
FROM sonarsource/sonar-scanner-cli:4.7 as sonars
# Install SonarScanner
#### Install Sonar Scanner
USER root
ENV SONAR_SCANNER_HOME /opt/sonar-scanner
COPY --from=sonars /opt/sonar-scanner ${SONAR_SCANNER_HOME}


RUN apt-get update -y && \
apt-get install -y wget unzip tar

# Install gnupg, lsb-release, and software-properties-common
RUN apt-get update -y && \
    apt-get install -y gnupg lsb-release software-properties-common


RUN apt-get update -y && \
    apt-get install -y apt-transport-https ca-certificates curl git make


RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
RUN apt-get update -y && \
    apt-get install -y docker-ce

VOLUME /var/run/docker.sock

RUN ${BAMBOO_USER_HOME}/bamboo-update-capability.sh "system.builder.sos" /usr/local/bin/sonar-scanner
RUN ${BAMBOO_USER_HOME}/bamboo-update-capability.sh "system.docker.executable" /usr/bin/docker
RUN ${BAMBOO_USER_HOME}/bamboo-update-capability.sh "system.builder.sos" ${SONAR_SCANNER_HOME}

USER bamboo

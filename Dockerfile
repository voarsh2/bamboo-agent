FROM atlassian/bamboo-agent-base:latest
USER root

RUN apt-get update -y && \
apt-get install -y wget unzip tar

RUN apt-get update -y && \
    apt-get install -y apt-transport-https ca-certificates curl git make


RUN apt-get install -y gnupg

RUN apt-get update -yq && \
    apt-get install -y -qq --no-install-recommends docker-ce


# Allow bamboo to access the docker daemon
RUN usermod -aG docker bamboo

USER ${BAMBOO_USER}

RUN ${BAMBOO_USER_HOME}/bamboo-update-capability.sh "system.docker.executable" /usr/bin/docker


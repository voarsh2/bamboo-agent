FROM atlassian/bamboo-agent-base:latest
USER root

RUN apt-get update -y && \
apt-get install -y wget unzip tar

RUN apt-get update -y && \
    apt-get install -y apt-transport-https ca-certificates curl git make


RUN apt-get install -y gnupg

RUN addgroup ${BAMBOO_GROUP} && \
     adduser --home ${BAMBOO_USER_HOME} --ingroup ${BAMBOO_GROUP} --disabled-password ${BAMBOO_USER}

# Allow bamboo to access the docker daemon
RUN usermod -aG docker bamboo


ENV DOWNLOAD_URL="https://download.docker.com"
ENV APT_URL="deb [arch=arm64] ${DOWNLOAD_URL}/linux/ubuntu bionic edge"

RUN curl -fsSL ${DOWNLOAD_URL}/linux/ubuntu/gpg | apt-key add -qq - >/dev/null
RUN echo "${APT_URL}" > /etc/apt/sources.list.d/docker.list

RUN apt-get update -yq && \
    apt-get install -y -qq --no-install-recommends docker-ce

RUN adduser bamboo docker

USER ${BAMBOO_USER}

RUN ${BAMBOO_USER_HOME}/bamboo-update-capability.sh "system.docker.executable" /usr/bin/docker


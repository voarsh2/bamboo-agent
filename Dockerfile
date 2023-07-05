FROM atlassian/bamboo-agent-base:latest
USER root

RUN apt-get update && \
    apt-get -y install apt-transport-https ca-certificates curl software-properties-common && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get -y install docker-ce docker-ce-cli containerd.io --without-sudo


RUN echo 'DOCKER_HOST="tcp://docker:2375"' >> /etc/environment

WORKDIR ${BAMBOO_USER_HOME}


# Switch back to the Bamboo user
USER bamboo

# Additional instructions if needed

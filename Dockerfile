FROM atlassian/bamboo-agent-base:latest
USER root

# Install required packages
RUN apt-get update && \
    apt-get -y install apt-transport-https ca-certificates curl software-properties-common && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get -y install docker-ce docker-ce-cli containerd.io

# Add the bamboo user to the docker group
RUN usermod -aG docker bamboo

# Switch back to the Bamboo user
USER bamboo

# Set the working directory
WORKDIR ${BAMBOO_USER_HOME}

# Additional instructions if needed

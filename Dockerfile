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

# Grant permissions to connect to the Docker daemon
RUN chmod 666 /var/run/docker.sock

# Configure DOCKER_HOST environment variable
RUN echo 'DOCKER_HOST="tcp://docker:2375"' >> /etc/environment

# Switch back to the Bamboo user
USER bamboo

# Set the working directory
WORKDIR ${BAMBOO_USER_HOME}

# Additional instructions if needed

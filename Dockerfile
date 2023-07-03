FROM atlassian/bamboo-agent-base:latest
USER root

# Install Docker dependencies
RUN apt-get update && \
    apt-get install -y apt-transport-https ca-certificates curl software-properties-common sudo

# Add Docker repository and install Docker
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get install -y docker-ce

# Allow Bamboo user to run Docker with sudo
RUN echo "${BAMBOO_USER} ALL=(ALL) NOPASSWD: /usr/bin/docker" >> /etc/sudoers.d/bamboo-user

# Switch back to the Bamboo user
USER ${BAMBOO_USER}

# Additional instructions if needed

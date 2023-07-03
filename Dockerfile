FROM atlassian/bamboo-agent-base:latest
USER root

# Install Docker dependencies
RUN apt-get update && \
    apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# Add Docker repository and install Docker
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get install -y docker-ce

# Create a script to modify the sudoers file
RUN echo '#!/bin/sh \n\
echo "bamboo ALL=(ALL) NOPASSWD: /usr/bin/docker" > /etc/sudoers.d/bamboo-user && \
chmod 0440 /etc/sudoers.d/bamboo-user' > /usr/local/bin/modify_sudoers.sh && \
chmod +x /usr/local/bin/modify_sudoers.sh

# Modify the sudoers file during the build process
RUN /usr/local/bin/modify_sudoers.sh

# Switch back to the Bamboo user
USER bamboo

# Additional instructions if needed

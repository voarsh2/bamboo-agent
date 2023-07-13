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
RUN sed -i 's/Defaults    requiretty/#Defaults    requiretty/g' /etc/sudoers && \
    echo "bamboo ALL=(ALL) NOPASSWD: /usr/bin/docker" > /etc/sudoers.d/bamboo-user && \
    echo "bamboo ALL=(ALL) NOPASSWD: /usr/sbin/service docker start" >> /etc/sudoers.d/bamboo-user && \
    chmod 0440 /etc/sudoers.d/bamboo-user

# Switch back to the Bamboo user
USER bamboo

# Additional instructions if needed

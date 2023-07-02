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

# Additional instructions if needed

# Set the user to root
USER root

# Additional instructions if needed

# Save the image with root as the default user
CMD ["/bin/bash"]

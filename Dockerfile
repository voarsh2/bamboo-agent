FROM atlassian/bamboo-agent-base:latest

# Docker-in-Docker
# Configuration parameters
ENV DOCKER_VERSION 20.10.7
ENV DOCKER_COMPOSE_VERSION 1.29.2
ENV DIND_COMMIT 9b55aab2c15bcb573919734d349e6bb4d996d0de

# Install Docker binary
RUN curl -fsSL https://download.docker.com/linux/static/stable/x86_64/docker-$DOCKER_VERSION.tgz | tar xzvf - --strip-components=1 -C /usr/local/bin

# Install Docker Compose
RUN curl -fsSL https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-Linux-x86_64 -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose

# Allow bamboo to access the docker daemon
RUN usermod -aG docker bamboo

# Install the helper script to make docker-in-docker possible
RUN wget "https://raw.githubusercontent.com/docker/docker/$DIND_COMMIT/hack/dind" -O /usr/local/bin/dind && chmod +x /usr/local/bin/dind

# By default, start the docker daemon inside the container
ENV DOCKER_DAEMON_AUTOSTART 1

ENTRYPOINT ["/usr/local/bin/dind"]

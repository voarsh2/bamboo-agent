FROM atlassian/bamboo-agent-base:latest
USER root

RUN set -x \
    && apt-get update \
    && apt-get --no-install-recommends --no-install-suggests --yes install \
    ca-certificates \
    curl \
    git \
    gnupg \
    openssh-client \
    tini \
    wget \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*


#   Install Docker

RUN set -x \
    && mkdir -p /etc/apt/keyrings  \
    && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
      | tee /etc/apt/sources.list.d/docker.list > /dev/null

RUN set -x \
    && apt-get update \
    && apt-get --no-install-recommends --no-install-suggests --yes install \
      docker-ce \
      docker-ce-cli \
      containerd.io \
      docker-buildx-plugin \
      docker-compose-plugin

WORKDIR ${BAMBOO_USER_HOME}


# Switch back to the Bamboo user
USER bamboo

# Additional instructions if needed

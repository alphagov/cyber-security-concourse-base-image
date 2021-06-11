FROM gdscyber/cyber-security-concourse-base-image

RUN apt-get update -y && \
        apt-get install -y nodejs npm && \
        apt-get clean

# Upgrade default ubuntu node version to current stable version
RUN npm install -g n
RUN n stable

RUN npm install -g \
        artillery \
        artillery-engine-kinesis

RUN mkdir -p /node_modules/artillery/bin && \
    ln -s /usr/local/bin/artillery \
        /node_modules/artillery/bin/artillery

VOLUME /artillery
WORKDIR /artillery

ENTRYPOINT ["/bin/bash"]

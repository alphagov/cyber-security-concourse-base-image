FROM gdscyber/cyber-security-concourse-base-image

RUN apt-get update -y && \
        apt-get install -y nodejs npm && \
        apt-get clean

RUN npm install -g \
        artillery \
        artillery-engine-kinesis

VOLUME /artillery
WORKDIR /artillery

ENTRYPOINT ["/bin/bash"]

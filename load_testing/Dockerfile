FROM gdscyber/cyber-security-concourse-base-image

RUN apt-get update -y && \
        apt-get install -y nodejs npm && \
        apt-get clean

RUN npm install --ignore-scripts artillery && \
        npm install --ignore-scripts artillery-engine-kinesis

VOLUME /artillery
WORKDIR /artillery

ENTRYPOINT ["/bin/bash"]

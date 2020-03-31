FROM ubuntu:latest

ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV LANG C.UTF-8

RUN apt-get update -y
RUN apt-get install -y python3.7 python3-distutils python3-pip
RUN apt-get install -y build-essential libssl-dev libffi-dev python3-dev
RUN apt-get install -y python3-venv
RUN apt-get install -y awscli jq curl
RUN apt-get install -y nodejs npm
RUN npm install --ignore-scripts artillery && npm install --ignore-scripts artillery-engine-kinesis

VOLUME /artillery
WORKDIR /artillery

ENTRYPOINT ["/bin/bash"]

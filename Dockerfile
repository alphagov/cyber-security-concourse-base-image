FROM ubuntu:18.04

ENV TF_VERSION 0.12.26

# expect need local time zone
ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

LABEL ubuntu="18.04"
LABEL terraform="$TF_VERSION"
LABEL user="gdscyber"
LABEL Name="cyber_concourse_pipeline"
LABEL Version=0.0.1

RUN apt-get update -y && \
        apt-get install -y \
        awscli \
        build-essential \
        ca-certificates \
        curl \
        gcc \
        git \
        jq \
        libbz2-dev \
        libc6-dev \
        libffi-dev \
        liblzma-dev \
        libncurses5-dev \
        libreadline-dev \
        libsqlite3-dev \
        libssl-dev \
        libxml2-dev \
        libxmlsec1-dev \
        llvm \
        make \
        musl \
        musl-dev \
        musl-tools \
        python3-dev \
        python3-distutils \
        python3-pip \
        python3.7 \
        python3.7-dev \
        python3.7-venv \
        tk-dev \
        unzip \
        wget \
        xz-utils \
        zip \
        zlib1g-dev \
        && \
        apt-get clean

# Python 3 encoding set
ENV LANG C.UTF-8

# Set Python priority to use v3.7
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 1 && \
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 2

# Symlink pip and python to use v3
RUN ln -s /usr/bin/python3 /usr/bin/python && \
    ln -s /usr/bin/pip3 /usr/bin/pip

# install terraform
WORKDIR /tmp

RUN curl https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip -o terraform_${TF_VERSION}_linux_amd64.zip && \
    curl https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_{$TF_VERSION}_SHA256SUMS -o terraform.sha && \
        echo if [ $(sha256sum -c terraform.sha 2>/dev/null | grep OK | wc -l) -eq 1 ]; then echo 'Terraform file integrity is good'; unzip terraform_${TF_VERSION}_linux_amd64.zip && mv terraform /usr/bin/terraform && rm terraform_${TF_VERSION}_linux_amd64.zip terraform.sha;fi

# Copy over AWS STS AssumeRole scripts
COPY bin /usr/local/bin
RUN chmod +x /usr/local/bin/*.sh

FROM ubuntu:18.04

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

# Install tfenv
RUN git clone https://github.com/tfutils/tfenv.git ~/.tfenv
RUN ln -s ~/.tfenv/bin/* /usr/local/bin
RUN tfenv install 0.12.26
RUN tfenv install 0.12.31
RUN tfenv install 0.14.7
RUN tfenv use 0.12.31

# Copy over AWS STS AssumeRole scripts
COPY bin /usr/local/bin
RUN chmod +x /usr/local/bin/*.sh
RUN chmod +x /usr/local/bin/*.py

# Install pyenv
RUN git clone https://github.com/pyenv/pyenv.git /root/.pyenv

# Required env vars for pyenv
ENV HOME /root
ENV PYENV_ROOT $HOME/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

# Install Pythons
RUN pyenv install 3.6.12
RUN pyenv install 3.7.5
RUN pyenv install 3.7.9
RUN pyenv install 3.8.7
RUN pyenv install 3.9.1

# Set default python version
RUN pyenv global 3.7.5

# Version attrition csls
ENV TF_VERSION 0.14.7
WORKDIR /tmp
RUN wget https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip && \
        wget https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_SHA256SUMS && \
        sha256sum --ignore-missing -c terraform_${TF_VERSION}_SHA256SUMS && \
        unzip terraform_${TF_VERSION}_linux_amd64.zip && \
        mv terraform /usr/bin/terraform-${TF_VERSION} && \
        rm terraform_${TF_VERSION}_linux_amd64.zip terraform_${TF_VERSION}_SHA256SUMS

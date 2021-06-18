FROM amazonlinux:2

ENV TF_DEFAULT_VERSION 0.12.31

# expect need local time zone
ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

LABEL terraform="$TF_VERSION"
LABEL user="gdscyber"
LABEL Name="cyber_concourse_pipeline"
LABEL Version=0.0.1

RUN yum groupinstall -y 'Development Tools' && amazon-linux-extras install -y python3.8 && yum install -y openssl-devel libffi-devel awscli jq which unzip git zip gcc wget glibc-devel python38-devel && yum clean all

# Python 3 encoding set
ENV LANG C.UTF-8

# Set default Python to be Python 3.8
RUN alternatives --install /usr/bin/python python /usr/bin/python3.8 1 && \
    alternatives --install /usr/bin/pip pip /usr/bin/pip3.8 1

# Copy over AWS STS AssumeRole scripts
COPY bin /usr/local/bin
RUN chmod +x /usr/local/bin/*.sh

# Install tfenv
RUN git clone https://github.com/tfutils/tfenv.git ~/.tfenv
RUN ln -s ~/.tfenv/bin/* /usr/local/bin
RUN tfenv install 0.12.26
RUN tfenv install 0.12.31
RUN tfenv install 0.14.7
RUN tfenv use $TF_DEFAULT_VERSION

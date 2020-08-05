FROM amazonlinux:2

ENV TF_VERSION 0.12.26

# expect need local time zone
ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

LABEL terraform="$TF_VERSION"
LABEL user="gdscyber"
LABEL Name="cyber_concourse_pipeline"
LABEL Version=0.0.1

RUN yum groupinstall 'Development Tools' && yum install openssl-devel libffi-devel awscli jq unzip git zip gcc wget glibc-devel && yum clean all

# Python 3 encoding set
ENV LANG C.UTF-8

# install terraform
ADD install_terraform.sh /tmp/install_terraform.sh
WORKDIR /tmp
RUN bash install_terraform.sh

# Copy over AWS STS AssumeRole scripts
COPY bin /usr/local/bin
RUN chmod +x /usr/local/bin/*.sh

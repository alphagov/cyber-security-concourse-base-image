FROM amazonlinux:2

WORKDIR /usr/src/app
RUN yum install -y apt-utils zip unzip make
RUN yum install -y python3.7 python3-distutils python3-pip
RUN yum install -y curl tar imagemagick python-gtk2
RUN yum install -y libpng libtiff fontconfig freetype libX11

# Install chromedriver and headless-chrome
RUN mkdir ./bin
COPY bin/* ./bin/
RUN bash bin/install_chrome.sh

ENV PATH=.:/opt:$PATH

# Install python deps
COPY requirements.txt .
RUN pip3 install -r requirements.txt

COPY . .

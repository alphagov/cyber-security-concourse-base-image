#! /bin/bash
CHROME_DRIVER_VERSION=86.0.4240.22
HEADLESS_CHROME_VERSION=v1.0.0-57

cd /opt
curl -SL https://chromedriver.storage.googleapis.com/${CHROME_DRIVER_VERSION}/chromedriver_linux64.zip > chromedriver.zip
unzip chromedriver.zip
rm chromedriver.zip
# download chrome binary
curl -SL https://github.com/adieuadieu/serverless-chrome/releases/download/${HEADLESS_CHROME_VERSION}/stable-headless-chromium-amazonlinux-2.zip > headless-chromium.zip
unzip headless-chromium.zip
rm headless-chromium.zip
ln -fs /opt/headless-chromium /opt/chrome

#touch /etc/yum.repos.d/google-chrome.repo
#echo -e "[google-chrome]\nname=google-chrome\nbaseurl=http://dl.google.com/linux/chrome/rpm/stable/\$basearch\nenabled=1\ngpgcheck=1\ngpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub" >> /etc/yum.repos.d/google-chrome.repo
#touch /etc/yum.repos.d/centos.repo
#echo -e "[CentOS-base]\nname=CentOS-6 - Base\nmirrorlist=http://mirrorlist.centos.org/?release=6&arch=x86_64&repo=os\ngpgcheck=1\ngpgkey=http://mirror.centos.org/centos/RPM-GPG-KEY-CentOS-6\n\n" >> /etc/yum.repos.d/centos.repo
#echo -e "#released updates\n[CentOS-updates]\nname=CentOS-6 - Updates\nmirrorlist=http://mirrorlist.centos.org/?release=6&arch=x86_64&repo=updates\ngpgcheck=1\ngpgkey=http://mirror.centos.org/centos/RPM-GPG-KEY-CentOS-6\n\n" >> /etc/yum.repos.d/centos.repo
#echo -e "#additional packages that may be useful\n[CentOS-extras]\nname=CentOS-6 - Extras\nmirrorlist=http://mirrorlist.centos.org/?release=6&arch=x86_64&repo=extras\ngpgcheck=1\ngpgkey=http://mirror.centos.org/centos/RPM-GPG-KEY-CentOS-6\n" >> /etc/yum.repos.d/centos.repo
#yum install -y google-chrome-stable
## google-chrome-stable --version
## which google-chrome-stable
#ln -fs /usr/bin/google-chrome-stable /opt/chrome
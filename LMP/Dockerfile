############################################################
# Dockerfile to build NewBiz container images
# Based on AmazonLinux
############################################################

# Set the base image to AmazonLinux
FROM amazonlinux:2018.03
MAINTAINER DuyHo

################## BEGIN INSTALLATION ###################### 

ADD sh/nginx.conf /tmp/nginx.conf
ADD sh/rvm.sh /tmp/rvm.sh
ADD sh/Gemfile /tmp/Gemfile
ADD sh/create-user.sh /tmp/create-user.sh
ADD sh/create-env.sh /tmp/create-env.sh

RUN yum update -y && yum install -y \
sudo \
gcc-c++ \
patch \
readline \ 
readline-devel \
zlib \
zlib-devel \
libyaml-devel \
libffi-devel \
openssl-devel \
make \
git \
bzip2 \
autoconf \
automake \
libtool \
bison \
iconv-devel \
sqlite-devel \
which \
pssh \
ImageMagick \
nginx \
mysql \
mysql-devel \
&& yum clean all

RUN curl -sSL https://rvm.io/mpapis.asc | gpg --import -
RUN curl -L get.rvm.io | bash -s stable
RUN source /tmp/rvm.sh
RUN /bin/bash -l -c "rvm reload"
RUN /bin/bash -l -c "rvm requirements run"
RUN /bin/bash -l -c "rvm install 2.5"

RUN /bin/bash -l -c "gem install rails -v 5.2.0"
RUN /bin/bash -l -c "gem install unicorn -v 5.4.0"
RUN /bin/bash -l -c "gem install pre-commit"

RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
RUN yum-config-manager --enable epel
RUN yum install -y redis

RUN curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
RUN curl --silent --location https://rpm.nodesource.com/setup_6.x | sudo bash -
RUN yum install -y yarn-1.7.0-1

RUN /bin/bash /tmp/create-user.sh && \
rm /tmp/create-user.sh && \
/bin/bash /tmp/create-env.sh && \
rm /tmp/create-env.sh

CMD /etc/init.d/nginx start && /etc/init.d/redis start;sleep infinity

###############################################################################
# Puppet Training Docker/Puppet common profile
# OS: CentOS 6 (centos6)
# Equivalent: RHEL 6
###############################################################################

FROM centos:centos6
MAINTAINER Luís Pedro Algarvio <lp.algarvio@gmail.com>
LABEL Description="Image that setups CentOS 6 with Puppet common requirements" Vendor="SOL-ICT" Version="1.0"

#
# Environment
#

ENV TERM linux
WORKDIR /root

#
# System packages
#

# Install dependencies and refresh keys
RUN yum makecache && yum install -y \
    yum-plugin-fastestmirror gnupg ca-certificates \
    procps tar gzip wget curl which nano \
    openssh-clients git \
    && yum clean all \
    && gpg --refresh-keys;

#
# Extra repositories
#

# Puppet Labs package collection 1
RUN wget -q http://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs && \
    gpg --import RPM-GPG-KEY-puppetlabs && \
    rpm --import RPM-GPG-KEY-puppetlabs && \
    rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-pc1-el-6.noarch.rpm && \
    yum makecache;

#
# Puppet environment
#

# Add Puppet to the PATH
RUN touch /etc/profile.d/puppet.sh; echo "export PATH=/opt/puppetlabs/bin:$PATH" > /etc/profile.d/puppet.sh;


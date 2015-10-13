###############################################################################
# Puppet Training Docker/Puppet Agent profile
# OS: CentOS 6 (centos6)
# Equivalent: RHEL 6
###############################################################################

FROM lpalgarvio/puppet-training:centos6_common
MAINTAINER Luís Pedro Algarvio <lp.algarvio@gmail.com>
LABEL Description="Image that setups a CentOS 6 with a Puppet Agent" Vendor="SOL-ICT" Version="1.0"

#
# Environment
#

ENV TERM linux
WORKDIR /root

#
# Puppet 4.x.x packages (from puppetlabs)
#

# Install Puppet Agent (Client)
RUN yum -y install puppet-agent && \
    yum clean packages;

# Update configuration
RUN printf "\
\n# Hostnames \
\ncertname = agent \
\nserver = master \
\n" >> /etc/puppetlabs/puppet/puppet.conf;

#
# Puppet service
#

# Enable service
RUN chkconfig puppet on;
RUN /bin/bash -l -c "puppet resource service puppet enable=true";

# First run
CMD /bin/bash -l -c "puppet agent --test --waitforcert 2m";

# Run service
CMD /opt/puppetlabs/bin/puppet agent --verbose --no-daemonize


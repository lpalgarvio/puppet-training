###############################################################################
# Puppet Training Docker/Puppet PuppetDB profile
# OS: CentOS 6 (centos6)
# Equivalent: RHEL 6
###############################################################################

FROM lpalgarvio/puppet-training:centos6_common
MAINTAINER Luís Pedro Algarvio <lp.algarvio@gmail.com>
LABEL Description="Image that setups a CentOS 6 with a PuppetDB" Vendor="SOL-ICT" Version="1.0"

#
# Environment
#

ENV TERM linux
WORKDIR /root

#
# Puppet 4.x.x packages (from puppetlabs)
#

# Install PuppetDB
RUN yum -y install java-1.7.0-openjdk puppetdb && \
    yum clean packages;
RUN /bin/bash -l -c "puppet resource package puppetdb ensure=latest";

# Update configuration
RUN printf "\
\n# Hostnames \
\ncertname = puppetdb \
\nserver = master \
\n" >> /etc/puppetlabs/puppet/puppet.conf;
RUN printf "\
[main] \
\nserver_urls = https://puppetdb:8081 \
\n" >> /etc/puppetlabs/puppet/puppetdb.conf;

#
# Puppet service
#

# Enable service
RUN chkconfig puppetdb on;
RUN /bin/bash -l -c "puppet resource service puppetdb enable=true";

# First run
CMD /bin/bash -l -c "puppet agent --test --waitforcert 2m";
CMD /bin/bash -l -c "puppetdb ssl-setup -f";

# Run service
CMD /usr/lib/jvm/jre-1.7.0-openjdk.x86_64/bin/java -cp /opt/puppetlabs/server/apps/puppetdb/puppetdb.jar clojure.main -m com.puppetlabs.puppetdb.core services -c /etc/puppetlabs/puppetdb/conf.d
EXPOSE 8080 8081 8082


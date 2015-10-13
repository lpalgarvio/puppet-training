###############################################################################
# Puppet Training Docker/Puppet Agent profile
# OS: CentOS 6 (centos6)
# Equivalent: RHEL 6
###############################################################################

FROM lpalgarvio/puppet-training:centos6_common
MAINTAINER Luís Pedro Algarvio <lp.algarvio@gmail.com>
LABEL Description="Image that setups a CentOS 6 with a Puppet Master" Vendor="SOL-ICT" Version="1.0"

#
# Environment
#

ENV TERM linux
WORKDIR /root

#
# Puppet 4.x.x packages (from puppetlabs)
#

# Install Puppet Master (Server)
RUN yum -y install puppetserver puppetdb-termini && \
    yum clean packages;
RUN /bin/bash -l -c "puppet resource package puppetdb-termini ensure=latest";

# Copy configuration and data
COPY resources/master/* /etc/puppetlabs/code/

# Update configuration
RUN sed -i 's>-Xms2g>-Xms256m>' /etc/sysconfig/puppetserver; sed -i 's>-Xmx2g>-Xmx256m>' /etc/sysconfig/puppetserver;

#
# Puppet Backends: PuppetDB
#

# Update configuration
RUN printf " \
\n# Hostnames \
\ncertname = master \
\ndns_alt_names = master,master.lan \
\n \
\n# PuppetDB \
\nstoreconfigs = false \
\nstoreconfigs_backend = puppetdb \
\nreports = store,puppetdb \
\n" >> /etc/puppetlabs/puppet/puppet.conf;
RUN printf " \
\nmaster: \
\n  # PuppetDB \
\n  facts: \
\n    terminus: puppetdb \
\n    cache: yaml \
\n" >> /etc/puppetlabs/puppet/routes.yaml;

#
# Puppet Backends: Hiera ENC
#

# Install Hiera-ENC
RUN git clone -b v1.0.0 https://github.com/Zetten/puppet-hiera-enc.git /etc/puppetlabs/code/hiera-enc;

# Create symlinks
RUN ln -sf /etc/puppetlabs/code /etc/puppet; ln -sf /etc/puppetlabs/code/hiera-enc/enc /opt/puppetlabs/bin/hiera-enc;

# Copy configuration and data
COPY resources/hiera-enc/* /etc/puppetlabs/code/hiera-enc/

# Update configuration
RUN printf " \
\n# Hiera-ENC \
\nnode_terminus = exec \
\nexternal_nodes = /etc/puppetlabs/code/hiera-enc/enc \
\n" >> /etc/puppetlabs/puppet/puppet.conf;

#
# Ruby and Rubygems (via puppet)
#

# Create symlinks
RUN ln -sf /opt/puppetlabs/puppet/bin/ruby /opt/puppetlabs/bin/ruby; ln -sf /opt/puppetlabs/puppet/bin/gem /opt/puppetlabs/bin/gem;

# Configure Rubygems
RUN echo "install: --no-rdoc --no-ri" >> ~/.gemrc; echo "update:  --no-rdoc --no-ri" >> ~/.gemrc;

#
# Librarian-Puppet gem
#

# Install Librarian-puppet 2.0.1 (for ruby >=1.9.x) gems
RUN /bin/bash -l -c "gem install librarian-puppet -v 2.0.1";

# Create symlinks
RUN ln -sf /opt/puppetlabs/puppet/bin/librarian-puppet /opt/puppetlabs/bin/librarian-puppet;

#
# Puppet Environments: Development
#

# Initialize the environment
RUN cp -R /etc/puppetlabs/code/environments/production /etc/puppetlabs/code/environments/development;
RUN /bin/bash -l -c "cd /etc/puppetlabs/code/environments/development; librarian-puppet init;";

# Copy configuration and data
COPY resources/environments/development/* /etc/puppetlabs/code/environments/development/

# Install the modules
RUN /bin/bash -l -c "cd /etc/puppetlabs/code/environments/development; librarian-puppet install; librarian-puppet update; librarian-puppet show";

#
# Puppet Environments: Production
#

# Initialize the environment
RUN /bin/bash -l -c "cd /etc/puppetlabs/code/environments/production; librarian-puppet init;";

# Copy configuration and data
COPY resources/environments/production/* /etc/puppetlabs/code/environments/production/

# Install the modules
RUN /bin/bash -l -c "cd /etc/puppetlabs/code/environments/production; librarian-puppet install; librarian-puppet update; librarian-puppet show";

#
# Puppet service
#

# Enable service
RUN chkconfig puppetserver on;
RUN /bin/bash -l -c "puppet resource service puppetserver enable=true";

# Run service
CMD /opt/puppetlabs/bin/puppet master --verbose --no-daemonize
EXPOSE 8140


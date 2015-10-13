#!/bin/sh

# Run interactive container
docker run \
  -i -t --name="puppet_training_centos6_puppetdb" \
  "lpalgarvio/puppet-training:centos6_puppetdb" \
  /bin/bash;


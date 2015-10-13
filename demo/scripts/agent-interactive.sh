#!/bin/sh

# Run interactive container
docker run \
  -i -t --name="puppet_training_centos6_agent" \
  "lpalgarvio/puppet-training:centos6_agent" \
  /bin/bash;


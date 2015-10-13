#!/bin/sh

# Run interactive container
docker run \
  -i -t --name="puppet_training_centos6_master" \
  "lpalgarvio/puppet-training:centos6_master" \
  /bin/bash;


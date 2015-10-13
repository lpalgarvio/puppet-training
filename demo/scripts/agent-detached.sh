#!/bin/sh

# Run detached container
docker run \
  -d --name="puppet_training_centos6_agent" \
  "lpalgarvio/puppet-training:centos6_agent";


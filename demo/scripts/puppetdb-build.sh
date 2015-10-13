#!/bin/bash

# Inherit settings
source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/../common.inc"

# Build image
docker build --quiet=false \
  -t "lpalgarvio/puppet-training:centos6_puppetdb" \
  --file="${dockerfiles_path}/puppetdb.dockerfile" \
  "${dockerfiles_path}";


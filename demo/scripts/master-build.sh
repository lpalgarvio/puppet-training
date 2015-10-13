#!/bin/bash

# Inherit settings
source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/../common.inc"

# Build image
docker build --quiet=false \
  -t "lpalgarvio/puppet-training:centos6_master" \
  --file="${dockerfiles_path}/master.dockerfile" \
  "${dockerfiles_path}";


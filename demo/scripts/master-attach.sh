#!/bin/sh

# Attach interactively to container
docker exec \
  -i -t "puppet_training_centos6_master" \
  /bin/bash;


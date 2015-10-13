# puppet-training
Presentation slides and demo for a Puppet Training.
Using docker, docker-compose, puppet 4.2 with agent and master, librarian-puppet, hiera-enc, hiera-yaml and puppetdb.


### Presentation

A presentation is included in this repo, produced with OpenDocument format, and can be found in the 'presentation' directory.

It covers the following topics:
- Puppet Basics
- Puppet Backends
- Puppet Code

##### Basics

In basics, we cover a standard setup using various methods, the terminology and the workflow.

We also talk about multiple environments and the usage of Librarian Puppet (librarian-puppet) to manage these.

##### Backends

In backends, we extend further our instalation by installing different kinds of backends:
 - External Node Classifier (ENC): hiera-enc
 - Pre-data: hiera-yaml
 - Post-data: PuppetDB

##### Code

In code, we will be looking at sample usage and programming of modules and classes.


### Demo

A demo is provided for the presentation, built with Docker, and located in the 'demo' directory.

It can produce the following images when built:
- lpalgarvio/puppet-training:centos6_common
- lpalgarvio/puppet-training:centos6_agent
- lpalgarvio/puppet-training:centos6_master
- lpalgarvio/puppet-training:centos6_puppetdb

Thus, the following containers can then be launched:
- puppet_training_centos6_agent
- puppet_training_centos6_master
- puppet_training_centos6_puppetdb

These will efectively build and launch a working master, puppetdb and agent node, using CentOS 6.

Note: we are using `docker-compose` to manage the containers.
See https://docs.docker.com/compose/install/ for installation.

##### Getting started

To start the build process, navigate to the 'demo' directory.

The directory listing looks like this:

```
demo
 |
 --- docker-compose.yml
 |
 --- containers-clean.sh
 |
 --- containers-start.sh
 |
 --- containers-status.sh
 |
 --- containers-stop.sh
 |
 --- images-build.sh
 |
 --- dockerfiles
 |    |
 |    --- agent.dockerfile
 |    |
 |    --- common.dockerfile
 |    |
 |    --- master.dockerfile
 |    |
 |    --- puppetdb.dockerfile
 |    |
 |    --- resources
 |         |
 |         --- ...
 |
 --- scripts
      |
      --- agent-attach.sh
      |
      --- master-attach.sh
      |
      --- puppetdb-attach.sh
      |
      --- ...
```

##### Building images

Run the `./demo/images-build.sh` script to get the docker build running for all the images.

The common image is used as base image for all the remaining images.

##### Managing containers

The containers can be launched together by using the script `./demo/containers-start.sh`.

To check their process status, run `./demo/containers-status.sh` or `docker ps`.

To stop them, run `./demo/containers-stop.sh`.

Since `docker-compose` is storing these persistently, use `./demo/containers-clean.sh` to remove the data permanently.

##### Accessing containers

No SSH server was installed in these containers and they only run one process each.

To login into a bash shell in them, you have to use a special `docker exec` command.

Helper scripts are located in the 'scripts' directory:
- `./demo/scripts/agent-attach.sh`: to login into agent
- `./demo/scripts/master-attach.sh`: to login into master
- `./demo/scripts/puppetdb-attach.sh`: to login into puppetdb

Additional scripts are provided for separate interactive (bash) and detached (background) launch, as well as individual build scripts.


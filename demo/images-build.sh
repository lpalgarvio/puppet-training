#!/bin/bash

# Inherit settings
source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/common.inc";

# Run common build
source "${scripts_path}/common-build.sh";

# Run Agent build
source "${scripts_path}/agent-build.sh";

# Run Master build
source "${scripts_path}/master-build.sh";

# Run PuppetDB build
#source "${scripts_path}/puppetdb-build.sh";


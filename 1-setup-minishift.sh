#!/bin/bash

# Environment
. ./0-env.sh

# add the location of minishift executable to PATH
# I also keep other handy tools like kubectl and kubetail.sh
# in that directory

minishift profile set istio-tutorial
minishift config set memory 8GB
minishift config set cpus 3
minishift config set vm-driver xhyve ## or virtualbox, or kvm, for Fedora
minishift config set image-caching true
minishift config set disk-size 50g # extra disk size for the vm
minishift addon enable admin-user
minishift addon enable anyuid

minishift start
minishift ssh -- sudo setenforce 0

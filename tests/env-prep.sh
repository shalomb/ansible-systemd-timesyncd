#!/bin/bash

set -eu
set -xv

# setup
if type -P apt; then
  apt-get -qq -y update
  apt-get install -y --no-install-recommends --no-install-suggests \
    ca-certificates curl dbus procps python-minimal python-urllib3

elif type -P zypper; then
  zypper -n install curl procps python python-xml

elif type -P dnf; then
  dnf install -y curl procps python

elif type -P yum; then
  source /etc/os-release
  if [[ $ID = rhel ]]; then
    curl http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
      -o /tmp/epel.rpm
    rpm -ivh /tmp/epel.rpm
    yum --disablerepo=* --enablerepo=epel install -y procps python-pip
  else
    yum install -y curl procps python
  fi

fi

if type -P pip; then
  pip install --upgrade pip
else
  curl https://bootstrap.pypa.io/get-pip.py | python
fi

pip install --upgrade ansible==2.5.5


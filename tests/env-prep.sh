#!/bin/bash

set -eu
set -xv

# setup
if type -P apt; then
  export DEBIAN_FRONTEND=noninteractive
  apt-get -qq -y update
  apt-get install -y --no-install-recommends --no-install-suggests \
    ca-certificates curl dbus procps python-minimal python-urllib3 \
    tzdata

elif type -P zypper; then
  zypper -n install curl procps python python-xml

elif type -P dnf; then
  dnf remove -y bash-completion
  dnf install -y curl dbus procps python tzdata

elif type -P yum; then
  source /etc/os-release
  if [[ $ID = rhel ]]; then
    curl http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
      -o /tmp/epel.rpm
    rpm -ivh /tmp/epel.rpm
    yum --disablerepo=* --enablerepo=epel install -y procps python-pip
  else
    yum install -y curl dbus procps python tzdata
  fi

fi

if type -P pip; then
  pip install --upgrade pip
else
  curl https://bootstrap.pypa.io/get-pip.py | python
fi

pip install --upgrade ansible==2.5.5

systemctl --version

sed -r -i '/ConditionVirtualization=/d' \
  /lib/systemd/system/systemd-timesyncd.service

sed -r -i '/ConditionVirtualization=/d' \
  /etc/systemd/system/sysinit.target.wants/systemd-timesyncd.service || true

systemctl daemon-reload
if systemctl enable   systemd-timesyncd.service; then
  systemctl restart  systemd-timesyncd.service ||
  { systemctl status   systemd-timesyncd.service; journalctl -xe; }
fi

timedatectl status


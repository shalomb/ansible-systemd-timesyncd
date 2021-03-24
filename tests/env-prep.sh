#!/bin/bash

set -eu
set -xv

# setup
if type -P apt; then
  export DEBIAN_FRONTEND=noninteractive
  apt-get -qq -y update
  apt-get install -y --no-install-recommends --no-install-suggests \
    ca-certificates curl dbus procps \
    python3-minimal pyton3-pip python3-setuptools python3-wheel \
    tzdata

elif type -P zypper; then
  zypper -n install curl procps python python-xml

elif type -P dnf; then
  dnf remove -y bash-completion || true
  dnf install -y curl dbus procps tzdata

elif type -P yum; then
  source /etc/os-release
  if [[ $ID = rhel ]]; then
    curl http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
      -o /tmp/epel.rpm
    rpm -ivh /tmp/epel.rpm
    yum --disablerepo=* --enablerepo=epel install -y procps python3-pip
  else
    yum install -y curl dbus procps python3-pip tzdata
  fi

fi


if type -P pip3; then
  pip3 install --upgrade pip
elif python3 -c 'import pip'; then
  python3 -m pip install -U pip
else
  curl https://bootstrap.pypa.io/get-pip.py | python3
fi

pip3 install --upgrade ansible==2.8.0

ansible --version

systemctl --version

sed -r -i '/ConditionVirtualization=/d' \
  /lib/systemd/system/systemd-timesyncd.service || true

sed -r -i '/ConditionVirtualization=/d' \
  /etc/systemd/system/sysinit.target.wants/systemd-timesyncd.service || true

systemctl daemon-reload
if systemctl enable   systemd-timesyncd.service; then
  systemctl restart  systemd-timesyncd.service ||
  { systemctl status   systemd-timesyncd.service; journalctl -xe; }
fi

timedatectl status


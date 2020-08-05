[![Build Status](https://travis-ci.org/shalomb/ansible-systemd-timesyncd.svg?branch=master)](https://travis-ci.org/shalomb/ansible-systemd-timesyncd)

Role Name
=========

Ansible role to configure the
[systemd-timesyncd](https://www.freedesktop.org/software/systemd/man/systemd-timesyncd.service.html)
service setting S/NTP and timezone parameters.

Requirements
------------

* systemd >= 2.9
* systemd-timesyncd.service unit
* dbus

Role Variables
--------------

```
config:
  timezone: 'Africa/Libreville'
  ntp_servers:
    - 0.pool.ntp.org
    - 1.pool.ntp.org
    - 2.pool.ntp.org
    - 3.pool.ntp.org
  root_distance_max_sec: 5
  poll_interval_max_sec: 2048
  poll_interval_min_sec: 32
```

Also see [defaults/main.yml](defaults/main.yml) for more information
on these parameters.

Dependencies
------------

- Debian-based running systemd-timesyncd
  (NOTE: systemd on the Redhat family (RHEL/Fedora/CentOs) is not compiled
   with timesyncd for NTP syncrhonization and uses chrony instelad)

Conflicts
---------

This role will likely fail to succeed in configuring `timesyncd` if
the following services are enabled/running on the system.

* ntp/ntpd - reference implementation
* chrony/chronyd

Example Playbook
----------------

```
- name: TC2 - Run ansible-systemd-timesyncd role
  hosts: localhost
  remote_user: root
  roles:
  - role: ansible-systemd-timesyncd
    config:
      timezone: 'Africa/Libreville'
```

Also see [tests/](./tests/test.yml) for how tests are run.

References
----------

* [systemd-timesyncd.service](https://www.freedesktop.org/software/systemd/man/systemd-timesyncd.service.html)
* [timesyncd.conf](https://www.freedesktop.org/software/systemd/man/timesyncd.conf.html#)
* [timedatectl](https://www.freedesktop.org/software/systemd/man/timedatectl.html#)
* [Time Synchronization with NTP and systemd](https://feeding.cloud.geek.nz/posts/time-synchronization-with-ntp-and-systemd/)
* [systemd/timesyncd.c](https://github.com/systemd/systemd/blob/master/src/timesync/timesyncd.c)

License
-------

Apache License, v2.0

Author Information
------------------

Shalom Bhooshi

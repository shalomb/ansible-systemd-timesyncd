v1.0.11 - 2020-08-05T17:09:08
-----------------------------

* Fix for break caused by pip not present as a module under python3?

v1.0.10 - 2020-08-05T16:59:04
-----------------------------

* Extend coverage to Debian 10, Debian Unstable, Ubuntu 20.04/Focal
* Improve handling of python3 changes
* Improve desired state testing

v1.0.9 - 2020-08-04T10:30:05
----------------------------

* Switch to Python 3 (Closes #2)
* Switch to ansible 2.8 for tests in Travis CI
  (we are not able to do > 2.8 due to bug in python < 3.7
  (https://github.com/ansible/ansible/issues/21982#issuecomment-282778843)
  and this is not available in <= Debian Stretch, Ubuntu Bionic) (Opens #3)

v1.0.6 - 2018-07-30T14:10:10
----------------------------

* Fix use of default values in configure tasks (#1)

v1.0.5 - 2018-08-12T23:49:55
----------------------------

* Install dbus only under docker

v1.0.4 - 2018-08-12T23:23:42
----------------------------

* Wait for timesyncd to sync NTP

v1.0.3 - 2018-07-15T21:44:23
----------------------------

* Fix util-linux conflict with bash-completion

v1.0.2 - 2018-07-10T11:46:38
----------------------------

* Drop dependencies meta section

v1.0.1 - 2018-07-10T11:41:44
----------------------------

* Documentation/meta update

v1.0.0 - 2018-07-10T11:05:23
----------------------------

* Initial release
* Support setting NTP & timezone parameters and RTC synchronization.
* Support Ubuntu, Debian and Fedora

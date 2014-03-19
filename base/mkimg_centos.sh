#!/bin/bash
## from https://raw.github.com/blalor/docker-centos-base/master/build_centos.sh
set -e

## requires running as root because filesystem package won't install otherwise,
## giving a cryptic error about /proc, cpio, and utime.  As a result, /tmp
## doesn't exist.
[ $( id -u ) -eq 0 ] || { echo "must be root"; exit 1; }

tmpdir=$( mktemp -d )
trap "echo removing ${tmpdir}; rm -rf ${tmpdir}" EXIT

febootstrap \
  -u http://mirror.centos.org/centos/6/updates/x86_64/ \
  -i centos-release \
  -i yum \
  -i iputils \
  -i tar \
  -i which \
  -i bash \
  -i http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm \
  centos65 \
  ${tmpdir} \
  http://mirror.centos.org/centos/6/os/x86_64/

febootstrap-run ${tmpdir} -- sh -c 'echo "NETWORKING=yes" > /etc/sysconfig/network'

## set timezone of container to UTC
febootstrap-run ${tmpdir} -- ln -f /usr/share/zoneinfo/Etc/UTC /etc/localtime

febootstrap-run ${tmpdir} -- yum clean all

## xz gives the smallest size by far, compared to bzip2 and gzip, by like 50%!
febootstrap-run ${tmpdir} -- tar -cf - . | xz > centos6.tar.xz

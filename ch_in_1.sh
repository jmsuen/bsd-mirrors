#!/bin/sh

update_conf=/etc/freebsd-update.conf
pkg_repos_d=/usr/local/etc/pkg/repos
portsnap_conf=/etc/portsnap.conf
make_conf=/etc/make.conf

echo "ServerName update.freebsd.cn" > update.conf
vi $update_conf
echo "SERVERNAME=portsnap.freebsd.cn" > portsnap.conf
vi $portsnap_conf
mkdir -p $pkg_repos_d
cp ./pkg.cnbsd.conf   $pkg_repos_d/cnbsd.conf
cp ./pkg.FreeBSD.conf $pkg_repos_d/FreeBSD.conf
cp ./pkg.USTC.conf    $pkg_repos_d/USTC.conf
cat ports.make.conf >> $make_conf

pkg update -f
freebsd-update fetch
portsnap fetch extract

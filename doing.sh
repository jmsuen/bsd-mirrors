#!/bin/sh

update_conf=/etc/freebsd-update.conf
pkg_repos_d=/usr/local/etc/pkg/repos
portsnap_conf=/etc/portsnap.conf
make_conf=/etc/make.conf

function set_update ()
{
echo "update"
# sed 's/ServerName*/#&/' 
# sed 's/ServerName/'
echo "ServerName update.freebsd.cn" > update.conf
vi $update_conf
freebsd-update fetch
}

function set_pkg ()
{
echo "pkg mirrors"
mkdir -p $pkg_repos_d
cp ./pkg.cnbsd.conf   $pkg_repos_d/cnbsd.conf
cp ./pkg.FreeBSD.conf $pkg_repos_d/FreeBSD.conf
cp ./pkg.USTC.conf    $pkg_repos_d/USTC.conf
pkg update -f
}

function set_portsnap ()
{
echo "portsnap"
# sed 's/SERVERNAME*/#&/' $portsnap_conf
# sed 's/SERVERNAME/' $portsnap_conf
echo "SERVERNAME=portsnap.freebsd.cn" > portsnap.conf
vi $portsnap_conf
portsnap fetch extract
}

function set_ports ()
{
echo "ports"
cat ports.make.conf >> $make_conf
}

set_update()
set_pkg()
set_portsnap()
set_ports()

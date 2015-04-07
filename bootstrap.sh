#!/bin/bash

if ! grep -q 6.5 /etc/issue; then
    echo "This script is meant to be run on CentOS 6.5" >&2
    exit 1
fi

YUMOPTS="-y"

bootstrapversion=/etc/vagrant-bootstrap-minimal.md5sum

if [ -e $bootstrapversion ] && cat "$0" | md5sum --status -c $bootstrapversion ; then
    echo "$0 has not changed since last run, skipping."
    exit 0
fi

function pkgversion() {
    local pkgname="$1"
    local targetver="$2"
    local curver=$( rpm -q --qf '%{VERSION}-%{RELEASE}' "$pkgname" )
    [ "$curver" == "$targetver" ]
}

tdir=/dev/shm

set -e
# make sure we're root
[ $EUID -eq 0 ]

yum install $YUMOPTS \
    patch \
    gcc-c++ \
    readline-devel \
    zlib-devel \
    libyaml-devel \
    libffi-devel \
    openssl-devel \
    autoconf \
    automake \
    libtool \
    bison \
    libicu \
    libxml2-devel \
    libxslt-devel \
    nfs-utils \
    git-core \
    man \
    sqlite-devel

rm -rvf $tdir/rpms
mkdir $tdir/rpms

# no need for firewall when running via vagrant, also makes it more
# difficult to make some things work easily
/sbin/chkconfig ip6tables off
/sbin/chkconfig iptables off
/sbin/service iptables stop
/sbin/service ip6tables stop

# nfs services
/sbin/service rpcbind start
/sbin/service rpcidmapd start
/sbin/service nfslock start
/sbin/service netfs start
/sbin/chkconfig rpcbind on
/sbin/chkconfig rpcidmapd on
/sbin/chkconfig nfslock on
/sbin/chkconfig netfs on

# symlink worksamples to /srv
ln -s /vagrant/worksample-batches /srv/worksample-batches

# install rbenv and ruby
git clone https://github.com/sstephenson/rbenv.git /home/vagrant/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> /home/vagrant/.bash_profile
echo 'eval "$(rbenv init -)"' >> /home/vagrant/.bash_profile
curl -o /usr/local/src/ruby-2.1.2.tar.gz http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.2.tar.gz
tar -C /usr/local/src -xzf /usr/local/src/ruby-2.1.2.tar.gz
cd /usr/local/src/ruby-2.1.2
./configure --prefix=/home/vagrant/.rbenv/versions/2.1.2/
make
make install
echo '2.1.2' >> /home/vagrant/.rbenv/version
chown -R vagrant:vagrant /home/vagrant/.rbenv/

# install percona
# yum install $YUMOPTS http://www.percona.com/downloads/percona-release/redhat/0.1-3/percona-release-0.1-3.noarch.rpm
# yum install $YUMOPTS Percona-Server-server-56.x86_64 Percona-Server-client-56.x86_64
# chkconfig mysql on
# service mysql start

# install beanstalkd
yum --enablerepo=epel install $YUMOPTS beanstalkd
/sbin/chkconfig beanstalkd on
/sbin/service beanstalkd start

# install memcached
yum install $YUMOPTS memcached
/sbin/chkconfig memcached on
/sbin/service memcached start

# clean up
rm -rvf $tdir/rpms
yum clean all

# mark that we've run this version of the script
cat "$0" | md5sum > $bootstrapversion

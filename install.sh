#!/bin/sh

#  Copyright 2016 Mark McKinstry
# 
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
# 
#    http://www.apache.org/licenses/LICENSE-2.0
# 
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.


set -e
set -u

redhat_family_install_deps() {
    yum -y install curl
}

redhat_family_install_puppet() {
    yum -y --nogpgcheck install /tmp/puppet.rpm
    rm /tmp/puppet.rpm

    yum -y install puppet-agent
    rm -f /tmp/puppet.rpm
}

debian_family_install_deps() {
    apt-get install -y curl
}

debian_family_install_puppet() {
    sudo dpkg -i /tmp/puppet.deb
    rm /tmp/puppet.deb
    apt-get update
    apt-get install -y puppet-agent
}

if lsb_release > /dev/null 2>&1; then
    OS=`lsb_release -si | tr 'A-Z' 'a-z'`
    VERSION=`lsb_release -sr`
    MAJOR_VERSION=`echo $VERSION | cut -d. -f1`
    CODENAME=`lsb_release -sc`
    if [ "$OS" = 'debian' ] || [ "$OS" = 'ubuntu' ]; then
	debian_family_install_deps
	curl -DL "http://apt.puppetlabs.com/puppetlabs-release-pc1-${CODENAME}.deb" > /tmp/puppet.deb
	debian_family_install_puppet
    elif [ "$OS" = 'centos' ] || [ "$OS" = 'fedora' ]; then
	redhat_family_install_deps
	if [ "$OS" = 'centos' ]; then
	    # wget -O /tmp/puppet.rpm "http://yum.puppetlabs.com/puppetlabs-release-pc1-el-${MAJOR_VERSION}.noarch.rpm"
	    curl -DL "http://yum.puppetlabs.com/puppetlabs-release-pc1-el-${MAJOR_VERSION}.noarch.rpm" > /tmp/puppet.rpm
	elif [ "$OS" = 'fedora' ]; then
	    # wget -O /tmp/puppet.rpm "http://yum.puppetlabs.com/puppetlabs-release-pc1-fedora-${MAJOR_VERSION}.noarch.rpm"
	    curl -DL  "http://yum.puppetlabs.com/puppetlabs-release-pc1-fedora-${MAJOR_VERSION}.noarch.rpm" > /tmp/puppet.rpm
	fi
    
	redhat_family_install_puppet
    fi
elif [ -f /etc/fedora-release ]; then
    redhat_family_install_deps
    RELEASE_RPM=`rpm -qf /etc/fedora-release`
    RELEASE=`rpm -q --qf '%{VERSION}' $RELEASE_RPM`
    curl -DL  "http://yum.puppetlabs.com/puppetlabs-release-pc1-fedora-${RELEASE}.noarch.rpm" > /tmp/puppet.rpm

    redhat_family_install_puppet
elif [ -f /etc/redhat-release ]; then
    redhat_family_install_deps
    RELEASE_RPM=`rpm -qf /etc/redhat-release`
    RELEASE=`rpm -q --qf '%{VERSION}' $RELEASE_RPM`
    curl -DL "http://yum.puppetlabs.com/puppetlabs-release-pc1-el-${RELEASE}.noarch.rpm" > /tmp/puppet.rpm
 
    redhat_family_install_puppet
fi

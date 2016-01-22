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
    if ! command -v curl; then
	yum -y install curl
    fi
}

redhat_family_install_puppet_repo() {
    yum -y --nogpgcheck install /tmp/puppet-repo.rpm
    rm -f /tmp/puppet-repo.rpm
}

debian_family_install_deps() {
    if ! command -v curl; then
	apt-get install -y curl
    fi
}

debian_family_install_puppet_repo() {
    sudo dpkg -i /tmp/puppet-repo.deb
    apt-get update
    rm -f /tmp/puppet-repo.deb
}


TYPE='pc1'
OS=''
OS_CODENAME=''
OS_MAJOR_VERSION=''

while getopts t: opt; do
    case $opt in
	t) TYPE="$OPTARG";;
	\?)
	    echo "Usage: $0 [-t install_type]"
	    exit 1
	;;
    esac
done


if lsb_release > /dev/null 2>&1; then
    OS=`lsb_release -si | tr 'A-Z' 'a-z'`
    VERSION=`lsb_release -sr`
    OS_MAJOR_VERSION=`echo $VERSION | cut -d. -f1`
    OS_CODENAME=`lsb_release -sc`
elif [ -f /etc/fedora-release ]; then
    OS='fedora'
    RELEASE_RPM=`rpm -qf /etc/fedora-release`
    OS_MAJOR_VERSION=`rpm -q --qf '%{VERSION}' $RELEASE_RPM`
elif [ -f /etc/redhat-release ]; then
    OS='el'
    RELEASE_RPM=`rpm -qf /etc/redhat-release`
    OS_MAJOR_VERSION=`rpm -q --qf '%{VERSION}' $RELEASE_RPM`
else
    echo "unknown operating system" >&2
    exit 1
fi


if  expr "x$TYPE" : 'xpc' > /dev/null; then
    if [ "$OS" = 'debian' ] || [ "$OS" = 'ubuntu' ]; then
	debian_family_install_deps
	curl -DL "http://apt.puppetlabs.com/puppetlabs-release-${TYPE}-${OS_CODENAME}.deb" > /tmp/puppet-repo.deb
	debian_family_install_puppet_repo
	apt-get install -y puppet-agent
    elif [ "$OS" = 'el' ] || [ "$OS" = 'fedora' ]; then
	redhat_family_install_deps
	curl -DL "http://yum.puppetlabs.com/puppetlabs-release-${TYPE}-${OS}-${OS_MAJOR_VERSION}.noarch.rpm" > /tmp/puppet-repo.rpm
	redhat_family_install_puppet_repo
	yum -y install puppet-agent
    fi
elif [ "$TYPE" = '23repo' ]; then
    if [ "$OS" = 'debian' ] || [ "$OS" = 'ubuntu' ]; then
	debian_family_install_deps
	curl -DL "http://apt.puppetlabs.com/puppetlabs-release-${OS_CODENAME}.deb" > /tmp/puppet-repo.deb
	debian_family_install_puppet_repo
	apt-get install -y puppet
    elif [ "$OS" = 'el' ] || [ "$OS" = 'fedora' ]; then
	redhat_family_install_deps
	curl -DL "http://yum.puppetlabs.com/puppetlabs-release-${OS}-${OS_MAJOR_VERSION}.noarch.rpm" > /tmp/puppet-repo.rpm
	redhat_family_install_puppet_repo
	yum -y install puppet

    fi
else
    echo "unknown puppet installation type $TYPE" >&2
    exit 1
fi

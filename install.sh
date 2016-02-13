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

download_url() {
    curl -D /tmp/curl_headers -L "$1" > "$2"
    if grep -q '404 Not Found' /tmp/curl_headers; then
	echo "could not download $1"
	exit 1
    fi
}

determine_puppet_repo() {
    case $PUPPET_VERSION in
	2*) PUPPET_REPO='23repo';
	    PUPPET_PACKAGE_NAME='puppet';
	    ;;
	3*) PUPPET_REPO='23repo';
	    PUPPET_PACKAGE_NAME='puppet';
	    ;;
	4*|*)
	    PUPPET_REPO='pc1';
	    PUPPET_PACKAGE_NAME='puppet-agent';
	    ;;
    esac
}
determine_puppet_package_version() {
    # we sometimes need to translate from puppet versions to puppet-agent versions
    # https://docs.puppetlabs.com/puppet/latest/reference/about_agent.html
    case "$PUPPET_VERSION" in
	'2.6')   PUPPET_PACKAGE_VERSION='2.6.18';;
	'2.7')   PUPPET_PACKAGE_VERSION='2.7.26';;
	'2')     PUPPET_PACKAGE_VERSION='2.7.26';;
	2*)                             ;;

	'3.0')   PUPPET_PACKAGE_VERSION='3.0.2';;
	'3.1')   PUPPET_PACKAGE_VERSION='3.1.1';;
	'3.2')   PUPPET_PACKAGE_VERSION='3.2.4';;
	'3.3')   PUPPET_PACKAGE_VERSION='3.3.2';;
	'3.4')   PUPPET_PACKAGE_VERSION='3.4.3';;
	'3.5')   PUPPET_PACKAGE_VERSION='3.5.1';;
	'3.6')   PUPPET_PACKAGE_VERSION='3.6.2';;
	'3.7')   PUPPET_PACKAGE_VERSION='3.7.5';;
	'3.8')   PUPPET_PACKAGE_VERSION='3.8.6';;
	'3')     PUPPET_PACKAGE_VERSION='3.8.6';;
	3*)                            ;;

	'4.0.0') PUPPET_PACKAGE_VERSION='1.0.1';;
	'4.0')   PUPPET_PACKAGE_VERSION='1.0.1';;

	'4.1.0') PUPPET_PACKAGE_VERSION='1.1.1';;
	'4.1')   PUPPET_PACKAGE_VERSION='1.1.1';;

	'4.2.0') PUPPET_PACKAGE_VERSION='1.2.1';;
	'4.2.1') PUPPET_PACKAGE_VERSION='1.2.3';;
	'4.2.2') PUPPET_PACKAGE_VERSION='1.2.6';;
	'4.2.3') PUPPET_PACKAGE_VERSION='1.2.7';;
	'4.2')   PUPPET_PACKAGE_VERSION='1.2.7';;

	'4.3.0') PUPPET_PACKAGE_VERSION='1.3.0';;
	'4.3.1') PUPPET_PACKAGE_VERSION='1.3.2';;
	'4.3.2') PUPPET_PACKAGE_VERSION='1.3.5';;
	'4.3')   PUPPET_PACKAGE_VERSION='1.3.5';;

	# install the latest in the puppet 4.x line
	'4')     PUPPET_PACKAGE_VERSION='';;
    esac
}

PUPPET_REPO=''
PUPPET_VERSION=''
PUPPET_PACKAGE_NAME=''
PUPPET_PACKAGE_VERSION=''
PUPPET_PACKAGE_AND_VERSION=''
OS=''
OS_CODENAME=''
OS_MAJOR_VERSION=''

while getopts v: opt; do
    case $opt in
	v) PUPPET_VERSION="$OPTARG";;
	\?)
	    echo "Usage: $0 [-v puppet_version]"
	    exit 1
	;;
    esac
done


if lsb_release > /dev/null 2>&1; then
    OS=`lsb_release -si | tr 'A-Z' 'a-z'`
    OS_VERSION=`lsb_release -sr`
    OS_MAJOR_VERSION=`echo $OS_VERSION | cut -d. -f1`
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

determine_puppet_repo
determine_puppet_package_version

if  expr "x$PUPPET_REPO" : 'xpc' > /dev/null; then
    if [ "$OS" = 'debian' ] || [ "$OS" = 'ubuntu' ]; then
	debian_family_install_deps
	download_url "http://apt.puppetlabs.com/puppetlabs-release-${PUPPET_REPO}-${OS_CODENAME}.deb" /tmp/puppet-repo.deb
	debian_family_install_puppet_repo

	if [ "$PUPPET_PACKAGE_VERSION" != '' ]; then
	    PUPPET_PACKAGE_AND_VERSION="${PUPPET_PACKAGE_NAME}=${PUPPET_PACKAGE_VERSION}"
	else
	    PUPPET_PACKAGE_AND_VERSION="$PUPPET_PACKAGE_NAME"
	fi
	apt-get install -y "${PUPPET_PACKAGE_AND_VERSION}"
    elif [ "$OS" = 'el' ] || [ "$OS" = 'fedora' ]; then
	redhat_family_install_deps
	download_url "http://yum.puppetlabs.com/puppetlabs-release-${PUPPET_REPO}-${OS}-${OS_MAJOR_VERSION}.noarch.rpm" /tmp/puppet-repo.rpm
	redhat_family_install_puppet_repo

	if [ "$PUPPET_PACKAGE_VERSION" != '' ]; then
	    PUPPET_PACKAGE_AND_VERSION="${PUPPET_PACKAGE_NAME}-${PUPPET_PACKAGE_VERSION}"
	else
	    PUPPET_PACKAGE_AND_VERSION="$PUPPET_PACKAGE_NAME"
	fi
	yum -y install "${PUPPET_PACKAGE_AND_VERSION}"
    fi
elif [ "$PUPPET_REPO" = '23repo' ]; then
    if [ "$OS" = 'debian' ] || [ "$OS" = 'ubuntu' ]; then
	debian_family_install_deps
	download_url "http://apt.puppetlabs.com/puppetlabs-release-${OS_CODENAME}.deb" /tmp/puppet-repo.deb
	debian_family_install_puppet_repo

	if [ "$PUPPET_PACKAGE_VERSION" != '' ]; then
	    PUPPET_PACKAGE_AND_VERSION="${PUPPET_PACKAGE_NAME}=${PUPPET_PACKAGE_VERSION}"
	else
	    PUPPET_PACKAGE_AND_VERSION="$PUPPET_PACKAGE_NAME"
	fi
	apt-get install -y "${PUPPET_PACKAGE_AND_VERSION}"
    elif [ "$OS" = 'el' ] || [ "$OS" = 'fedora' ]; then
	redhat_family_install_deps
	download_url "http://yum.puppetlabs.com/puppetlabs-release-${OS}-${OS_MAJOR_VERSION}.noarch.rpm" /tmp/puppet-repo.rpm
	redhat_family_install_puppet_repo

	if [ "$PUPPET_PACKAGE_VERSION" != '' ]; then
	    PUPPET_PACKAGE_AND_VERSION="${PUPPET_PACKAGE_NAME}-${PUPPET_PACKAGE_VERSION}"
	else
	    PUPPET_PACKAGE_AND_VERSION="$PUPPET_PACKAGE_NAME"
	fi
	yum -y install "${PUPPET_PACKAGE_AND_VERSION}"
    fi
else
    cat <<EOF >&2
Unknown puppet installation type:
---
PUPPET_PACKAGE_VERSION: ${PUPPET_PACKAGE_VERSION}
PUPPET_PACKAGE_NAME: ${PUPPET_PACKAGE_NAME}
PUPPET_REPO: ${PUPPET_REPO}
EOF
    exit 1
fi

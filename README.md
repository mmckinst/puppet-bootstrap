This is an installation script for puppet that will install that latest version
of the
[puppet-agent](https://docs.puppetlabs.com/puppet/latest/reference/about_agent.html)
package from the
[puppet collections](https://puppetlabs.com/blog/welcome-puppet-collections)
repo for the following operating systems:

* CentOS 5
* CentOS 6
* CentOS 7
* Ubuntu 14.04
* Ubuntu 15.04
* Debian 7
* Debian 8
* Fedora 22


Usage
---
```
curl https://raw.githubusercontent.com/mmckinst/puppet-bootstrap/install.sh | sh
```

Todo
---
* Allow installation of specific versions of the puppet-agent package.
* Allow installation of specific versions of puppet 3.x packages from puppet's
  yum and apt repos.
* Allow installation of specific versions of puppet as a gem.


Contributing
---
Write code that works on a POSIX compatible, avoid bashisms.

* http://mywiki.wooledge.org/Bashism
* https://wiki.ubuntu.com/DashAsBinSh


License
---
```
Copyright 2016 Mark McKinstry

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

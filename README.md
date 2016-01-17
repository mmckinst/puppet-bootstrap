[![Travis](https://img.shields.io/travis/mmckinst/puppet-bootstrap.svg)](https://travis-ci.org/mmckinst/puppet-bootstrap)

This script will install the puppet agent on a server. It defaults to puppet 4.x
from the
[puppet collections](https://puppetlabs.com/blog/welcome-puppet-collections)
repo.

| OS           | 4.x | 3.x     |
|:-------------|:---:|:-------:|
| CentOS 5     | Yes | Yes     |
| CentOS 6     | Yes | Yes     |
| CentOS 7     | Yes | Yes     |
| Ubuntu 12.04 | Yes | Yes     |
| Ubuntu 14.04 | Yes | Yes     |
| Ubuntu 15.04 | Yes | **No**  |
| Debian 6     | Yes | Yes     |
| Debian 7     | Yes | Yes     |
| Debian 8     | Yes | Yes     |
| Fedora 22    | Yes | **No**  |


Usage
---
Install puppet 4.x from [puppet collections](https://puppetlabs.com/blog/welcome-puppet-collections):
```
curl https://raw.githubusercontent.com/mmckinst/puppet-bootstrap/master/install.sh | sudo sh
```

Install puppet 3.x from puppet's repo:
```
curl https://raw.githubusercontent.com/mmckinst/puppet-bootstrap/master/install.sh | sudo sh -- -t 23repo
```

Todo
---
* https://github.com/test-kitchen/test-kitchen/issues/917 so 23repo can have testing
* Allow installation of specific versions of puppet 4.x / [puppet-agent](https://docs.puppetlabs.com/puppet/latest/reference/about_agent.html) package.
* Allow installation of specific versions of puppet 3.x packages from puppet's
  yum and apt repos.
* Allow installation of specific versions of puppet as a gem.


Contributing
---
Write code that works on a POSIX compatible shell, avoid bashisms.

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

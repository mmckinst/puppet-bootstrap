[![Travis](https://img.shields.io/travis/mmckinst/puppet-bootstrap.svg)](https://travis-ci.org/mmckinst/puppet-bootstrap)

This script will install the puppet agent on a server. It defaults to puppet 4.x
from the
[puppet collections](https://puppetlabs.com/blog/welcome-puppet-collections)
repo.


Usage
---
Install the latest in the puppet 4.x line:
```
curl https://raw.githubusercontent.com/mmckinst/puppet-bootstrap/master/install.sh | sudo sh
```

Install the latest in the puppet 4.2.x line:
```
curl https://raw.githubusercontent.com/mmckinst/puppet-bootstrap/master/install.sh | sudo sh -- -v 4.2
```

Install the latest in the puppet 3.x line:
```
curl https://raw.githubusercontent.com/mmckinst/puppet-bootstrap/master/install.sh | sudo sh -- -v 3
```

Install the latest in the puppet 3.6.x line:
```
curl https://raw.githubusercontent.com/mmckinst/puppet-bootstrap/master/install.sh | sudo sh -- -v 3.6
```


Supported Operating Systems
---
| OS           | 4.x | 3.x     |
|:-------------|:---:|:-------:|
| CentOS 5     | Yes | Yes     |
| CentOS 6     | Yes | Yes     |
| CentOS 7     | Yes | Yes     |
| Ubuntu 12.04 | Yes | Yes     |
| Ubuntu 14.04 | Yes | Yes     |
| Ubuntu 15.04 | Yes | **No**  |
| Ubuntu 15.10 | Yes | **No**  |
| Debian 6     | Yes | Yes     |
| Debian 7     | Yes | Yes     |
| Debian 8     | Yes | Yes     |


Todo
---
* Allow installation of specific versions of puppet as a gem.


Contributing
---
Write code that works on a POSIX compatible shell, avoid bashisms.

* http://mywiki.wooledge.org/Bashism
* https://wiki.ubuntu.com/DashAsBinSh

Testing is done with kitchen and docker. To run the tests locally, you need to
have a working docker installation.

```
bundle install --path vendor/bundle
bundle exec kitchen test
```


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

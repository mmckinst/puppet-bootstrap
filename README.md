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
Copyright (c) 2016 Mark McKinstry

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

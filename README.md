Okta-OpenVPN Build Project
==========================
[![Build Status](https://img.shields.io/travis/socrata-platform/okta-openvpn-build.svg)][travis]
[![Coverage Status](https://img.shields.io/coveralls/socrata-platform/okta-openvpn-build.svg)][coveralls]

[travis]: https://travis-ci.org/socrata-platform/okta-openvpn-build
[coveralls]: https://coveralls.io/r/socrata-platform/okta-openvpn-build

A project for package the Okta OpenVPN plugin using Omnibus.

This project currently builds for Ubuntu 14.04 only. More platforms may be added
if time allows.

Requirements
------------

This project is distributed as a Chef cookbook that contains an Omnibus project.
This allows for automated builds in Vagrant or Docker environments using Test
Kitchen.

You must have a sane Ruby 2.0.0+ environment with Bundler installed. Ensure all
the required gems are installed:

```shell
$ bundle install --binstubs
```

Usage
-----

The included Test Kitchen config handles all the builds automatically for the
supported platforms. Normally, these builds will be kicked off and run on the
CI server, which will use Test Kitchen to assemble new packages, install them,
verify them, and publish them to PackageCloud.io.

Should the need arise, `omnibus` commands can still be run from the project
directory in `files/default/omnibus-okta-openvpn`.

Recipes
-------

Libraries
---------

Attributes
----------

Contributing
------------

Pull requests are welcome!

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Add tests for the new feature; ensure they pass (`rake`)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new Pull Request

License & Authors
=================
- Author: Jonathan Hartman <jonathan.hartman@socrata.com>

Copyright 2016, Socrata, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

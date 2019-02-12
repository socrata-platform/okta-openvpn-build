# Okta-OpenVPN Build Project

[![Build Status](https://img.shields.io/travis/socrata-platform/okta-openvpn-build.svg)][travis]

[travis]: https://travis-ci.org/socrata-platform/okta-openvpn-build

A project for packaging the Okta OpenVPN plugin and the Okta OpenVPN with
OpenSSL-FIPS 140-2 verification.

This project currently builds packages for Ubuntu 18.04/16.04/14.04 and
RHEL/CentOS/etc. 7.

## Requirements

This project is distributed as a Chef cookbook that contains an FPM Cookery
packaging recipe. This allows for automated builds in Vagrant or Docker
environments using Test Kitchen.

## Usage

The included Test Kitchen config handles all the builds automatically for the
supported platforms. Normally, these builds will be kicked off and run on the
CI server, which will use Test Kitchen to assemble new packages, install them,
verify them, and publish them to PackageCloud.io.  The Okta OpenVPN-FIPS will
test and build in the same manner.  The difference is that the packages are
published to [bintray](https://bintray.com/socrata).

Should the need arise, `fpm-cook` commands can still be run from the project
directory in `files/default/fpm-recipes`.

Packages are saved locally in `pkg/` when they are created on the Docker
Containers.

### Bintray Repositories

#### Ubuntu

- [apt](https://bintray.com/socrata/apt/okta-openvpn-fips)

#### CentOS/RHEL 7

- [rpm](https://bintray.com/socrata/rpm/okta-openvpn-fips)

## Recipes

***default***

Configures the included helper libraries and ties the below recipes together
for a standard OpenVPN with Integrated Okta package.

***fips***

Does the same as `default` but uses an OpenVPN package that is FIPS 140-2
verified.

***_build***

Installs build dependencies and runs `fpm-cook`.

***_verify***

Installs the newly-built package and runs a set of ServerSpec tests against it.

***_deploy***

Depending on attributes set, it will either include `_bintray` or
`_soundcloud`.

***_bintray***

Creates a travis compatible `bintray` deployment json document so that packages
can be uploaded to bintray from TravisCI.

***_soundcloud***

If an attribute is set to enable it, uploads the artifact to PackageCloud.io.

## Libraries

***helpers***

Helper methods for interacting with the PackageCloud API and handling the
generated package files.

## Attributes

***default***

Includes attributes for enabling artifact publishing, a PackageCloud API token,
and the package version and revision to use in the build.

***_bintray***

Attributes that get used in the `bintray.erb` template.

***fips***

Includes attributes for enabling artifact publishing, enabling fips_mode, and
the package version and revision to use in the build.

## Contributing

Pull requests are welcome!  Please see [here](https://github.com/socrata-platform/okta-openvpn-build/blob/master/files/CONTRIBUTING.md).
) on how to contribute:

Contributions can be submitted via GitHub pull requests. See [this article](https://help.github.com/articles/about-pull-requests/) if you're not familiar with GitHub Pull Requests. In brief:

1. Fork the project's repo in GitHub.
2. Create your feature branch (`git checkout -b my-new-feature`).
3. Add code and tests for the new feature.
4. Ensure all tests pass (`chef exec delivery local all` + `chef exec microwave test`).
5. Bump the version string in `metadata.rb` in accordance with [semver](http://semver.org).
6. Add a brief description of the change to `CHANGELOG.md`.
7. Commit your changes (`git commit -am 'Add some feature'`).
8. Push the branch to GitHub (`git push origin my-new-feature`).
9. Create a new pull request.
10. Ensure the build process for the pull request succeeds.
11. Enjoy life until the change can be reviewed by a cookbook maintainer.

## License & Authors

- Author: Jonathan Hartman <jonathan.hartman@tylertech.com>

Copyright 2016, Tyler Technologies

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

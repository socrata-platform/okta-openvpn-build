# frozen_string_literal: true

name 'okta-openvpn-build'
maintainer 'Jonathan Hartman'
maintainer_email 'jonathan.hartman@tylertech.com'
license 'Apache-2.0'
description 'Builds Okta-OpenVPN packages'
long_description 'Builds Okta-OpenVPN packages'
version '0.1.0'
chef_version '>= 14.0'

source_url 'https://github.com/socrata-platform/okta-openvpn-build'
issues_url 'https://github.com/socrata-platform/okta-openvpn-build/issues'

depends 'yum-epel'

supports 'ubuntu'
supports 'redhat', '>= 7.0'
supports 'centos', '>= 7.0'
supports 'scientific', '>= 7.0'

# frozen_string_literal: true

#
# FPM Recipe:: okta-openvpn
#
# Copyright 2016, Tyler Technologies
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'net/http'
require 'fpm/cookery/recipe'

# A FPM Cookery recipe for the Okta-OpenVPN plugin
#
# @author Jonathan Hartman <jonathan.hartman@tylertech.com>
class OktaOpenvpn < FPM::Cookery::Recipe
  name 'okta-openvpn'

  version ENV['BUILD_VERSION']
  revision ENV['BUILD_REVISION']

  description 'The Okta plugin for OpenVPN'
  homepage 'https://github.com/okta/okta-openvpn'
  source 'https://github.com/socrata-platform/okta-openvpn',
         with: :git,
         tag: "v#{version}"

  maintainer 'Jonathan Hartman <jonathan.hartman@tylertech.com>'
  vendor 'Tyler Technologies'

  license 'Apache, version 2.0'

  build_deps = %w[git python python-setuptools python-pip swig]
  deps = %w[python openvpn]

  platforms %i[debian ubuntu] do
    build_depends build_deps + %w[python-dev libssl-dev]
    depends deps
  end

  platforms %i[redhat centos scientific] do
    build_depends build_deps + %w[python-devel openssl-devel rpm-build]
    depends deps
  end

  #
  # Modify okta_openvpn.py to import our Omnibussed copies of the three Okta
  # plugin dependencies instead of looking in the normal Python paths.
  #
  def build
    inline_replace 'Makefile' do |s|
      s.gsub!('/lib/openvpn/plugins', '/lib/openvpn/plugins/okta')
    end
    inline_replace 'okta_openvpn.py' do |s|
      s.gsub!(/^import ConfigParser$/,
              "import sys\n" \
              "sys.path.append(\"/usr/lib/openvpn/plugins/okta\")\n" \
              'import ConfigParser')
    end
    make
  end

  #
  # Install the three Python dependencies in with the Okta plugin. Certifi
  # isn't packaged for Ubuntu prior to 16.04 and the others are out of date
  # compared to what the Okta plugin asks for.
  #
  def install
    make :install, DESTDIR: destdir
    %w[typing urllib3 certifi].each do |m|
      safesystem("pip install --no-deps -U -t #{pluginsdir}/okta #{m}")
    end
    # M2Crypto needs a little extra help to install without error
    safesystem("pip install --no-deps -U -t #{pluginsdir}/okta " \
               "--install-option='--install-lib=$base/lib/python' M2Crypto")
    f = File.open("#{pluginsdir}/okta/__init__.py", 'w')
    f.write("__version__ = \"#{version}\"")
    f.close
    safesystem("python -m compileall #{destdir}/usr/lib/openvpn/plugins/okta")
  end

  #
  # Return the OpenVPN plugins directory inside the package destination dir.
  #
  def pluginsdir
    "#{destdir}/usr/lib/openvpn/plugins"
  end
end

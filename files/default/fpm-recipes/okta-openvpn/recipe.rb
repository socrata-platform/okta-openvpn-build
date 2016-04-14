# Encoding: UTF-8
#
# FPM Recipe:: okta-openvpn
#
# Copyright 2016, Socrata, Inc.
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
# @author Jonathan Hartman <jonathan.hartman@socrata.com>
class OktaOpenvpn < FPM::Cookery::Recipe
  name 'okta-openvpn'

  version ENV['BUILD_VERSION']
  revision ENV['BUILD_REVISION']

  description 'The Okta plugin for OpenVPN'
  homepage 'https://github.com/okta/okta-openvpn'
  source 'https://github.com/okta/okta-openvpn',
         with: :git,
         tag: "v#{version}"

  maintainer 'Jonathan Hartman <jonathan.hartman@socrata.com>'
  vendor 'Socrata, Inc.'

  license 'Apache, version 2.0'

  build_depends %w(git python python-pip python-dev libssl-dev swig)

  depends %w(python python-urllib3 python-m2crypto)

  #
  # Modify okta_openvpn.py to import our Omnibussed copy of the Certifi module
  # instead of looking for it in the normal Python paths.
  #
  def build
    inline_replace 'okta_openvpn.py' do |s|
      s.gsub!(/^import certifi$/, 'from okta_openvpn import certifi')
    end
    make
  end

  #
  # Install the Certifi module in with the Okta plugin. There is no
  # python-certifi package in Ubuntu prior to 16.04 but we want to maintain as
  # few of our own packages as we have to.
  #
  def install
    make :install, DESTDIR: destdir
    pluginsdir = "#{destdir}/usr/lib/openvpn/plugins"
    safesystem("pip install --no-deps -U certifi -t #{pluginsdir}/okta_openvpn")
    f = File.open("#{pluginsdir}/okta_openvpn/__init__.py", 'w')
    f.write("__version__ = \"#{version}\"")
    f.close
    safesystem("python -m compileall #{destdir}/usr/lib/openvpn/plugins")
  end
end

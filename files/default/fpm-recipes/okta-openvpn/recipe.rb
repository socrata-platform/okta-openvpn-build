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
  # Modify okta_openvpn.py to import our Omnibussed copies of the three Okta
  # plugin dependencies instead of looking in the normal Python paths.
  #
  def build
    inline_replace 'okta_openvpn.py' do |s|
      %w(M2Crypto urllib3 certifi).each do |m|
        s.gsub!(/^import #{m}$/, "from okta_openvpn import #{m}")
      end
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
    pluginsdir = "#{destdir}/usr/lib/openvpn/plugins"
    %w(M2Crypto urllib3 certifi).each do |m|
      safesystem("pip install --no-deps -U -t #{pluginsdir}/okta_openvpn #{m}")
    end
    f = File.open("#{pluginsdir}/okta_openvpn/__init__.py", 'w')
    f.write("__version__ = \"#{version}\"")
    f.close
    safesystem("python -m compileall #{destdir}/usr/lib/openvpn/plugins")
  end
end

# Encoding: UTF-8
#
# Project Name:: okta-openvpn
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

name 'okta-openvpn'
maintainer 'Jonathan Hartman <jonathan.hartman@socrata.com>'
homepage "https://github.com/socrata-platform/okta-openvpn-build"

# Defaults to C:/okta-openvpn on Windows
# and /opt/okta-openvpn on all other platforms
install_dir "#{default_root}/#{name}"

build_version ENV['BUILD_VERSION']
build_iteration ENV['BUILD_REVISION']

dependency 'preparation'
dependency 'okta-openvpn'
dependency 'version-manifest'

exclude '**/.git'
exclude '**/bundler/git'

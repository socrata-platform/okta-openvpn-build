# Encoding: UTF-8
#
# Project Name:: okta-openvpn
# Software Name:: okta-openvpn
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
default_version "v#{ENV['BUILD_VERSION']}"

source git: 'https://github.com/okta/okta-openvpn'

dependency 'python'
dependency 'python-urllib3'
dependency 'python-m2crypto'
dependency 'python-certifi'

build do
  # Setup a default environment from Omnibus - you should use this Omnibus
  # helper everywhere. It will become the default in the future.
  env = with_standard_compiler_flags(with_embedded_path)

  command "make -j #{workers}", env: env
  command "make -j #{workers} install DESTDIR=#{install_dir}", env: env
end

# frozen_string_literal: true

#
# Cookbook Name:: okta-openvpn-build
# Recipe:: _verify
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

chef_gem 'serverspec'

case node['platform_family']
when 'debian'
  dpkg_package 'okta-openvpn' do
    package_name OktaOpenvpnBuild::Helpers.package_file
  end
when 'rhel'
  rpm_package 'okta-openvpn' do
    package_name OktaOpenvpnBuild::Helpers.package_file
  end
end

remote_directory '/tmp/spec'

execute '/opt/chef/embedded/bin/rspec */*_spec.rb -f d' do
  cwd '/tmp/spec'
end

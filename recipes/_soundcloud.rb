# frozen_string_literal: true

#
# Cookbook Name:: okta-openvpn-build
# Recipe:: _soundcloud
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

chef_gem 'packagecloud-ruby'

ruby_block 'Push artifacts to PackageCloud' do
  block do
    OktaOpenvpnBuild::Helpers.push_package!
  end

  only_if { node['okta_openvpn_build']['publish_artifacts'] }
end

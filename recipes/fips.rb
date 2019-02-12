# frozen_string_literal: true

#
# Cookbook Name:: okta-openvpn-build
# Recipe:: fips
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

# In order to have a FIPS Verified Openvpn package, we need to use a package
# that was appropriately packaged.  The build process for this Openvpn package
# can be found here: https://github.com/socrata-platform/omnibus-openvpn-fips
if node['platform_family'].include?('rhel')
  package('yum-priorities') { action :install }
  yum_repository  'socrata' do
    description   'bintray-socrata-rpm-openvpn-fips'
    baseurl       'https://dl.bintray.com/socrata/rpm/'
    priority      '1'
    gpgcheck      false
    repo_gpgcheck false
    enabled       true
    gpgkey        'https://bintray.com/user/downloadSubjectPublicKey?username=socrata'
  end
else
  if node['platform_version'].include?('18.04')
    # For some reason, the 18.04 image doesn't include this package, which
    # prevents apt_repo to add a repo with a gpg key included.
    package('gpg-agent') { action :install }
  end
  apt_repository 'socrata' do
    uri          'http://dl.bintray.com/socrata/deb/'
    arch         'amd64'
    distribution 'stable'
    components   ['main']
    key          'https://bintray.com/user/downloadSubjectPublicKey?username=socrata'
  end
end

include_recipe "#{cookbook_name}::default"
include_recipe "#{cookbook_name}::_deploy"

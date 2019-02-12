# frozen_string_literal: true

#
# Cookbook Name:: okta-openvpn-build
# Attributes:: _bintray
#
# Copyright 2019, Socrata, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'json'

platform = if platform_family?('rhel')
             'rpm'
           else
             'deb'
           end

upload_pattern = if platform_family?('rhel')
                   '/el/7/x86_64/okta-openvpn-fips/$1'
                 else
                   'pool/o/okta-openvpn-fips/$1'
                 end

distro_pattern = if platform_family?('rhel')
                   [
                     {
                       'includePattern': "pkg/(.*\\.#{platform})$",
                       'uploadPattern': upload_pattern.to_s,
                       'matrixParams': {
                         'override': 1
                       }
                     }
                   ]
                 else
                   [
                     {
                       'includePattern': "pkg/(.*\\.#{platform})$",
                       'uploadPattern': upload_pattern.to_s,
                       'matrixParams': {
                         'deb_distribution': 'stable',
                         'deb_component': 'main',
                         'deb_architecture': 'amd64',
                         'override': 1
                       }
                     }
                   ]
                 end

default['bintray'].tap do |b|
  b['package'].tap do |p|
    p['name'] = 'okta-openvpn'
    p['subject'] = 'socrata'
    p['repo'] = platform.to_s
    p['desc'] = 'OpenVPN with FIPS140-2 Verification and Okta integration'
    p['website_url'] = 'https://socrata.com/'
    p['issue_tracker_url'] = 'https://github.com/socrata-platform/okta-openvpn-build/issues'
    p['vcs_url'] = 'https://github.com/socrata-platform/okta-openvpn-build.git'
    p['labels'] = %w[openvpn fips openssl okta]
    p['licenses'] = ['Apache-2.0']
  end
  b['version'].tap do |v|
    v['name'] = node['okta_openvpn_build']['version']
    v['desc'] = b['package']['desc']
    v['released'] = Time.new.strftime('%Y-%m-%d')
    v['vcs_tag'] = node.run_context.cookbook_collection['okta-openvpn-build'].version
  end
  b['files'].tap do |f|
    f['distro_pattern'] = distro_pattern.to_json
  end
end

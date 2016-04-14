# Encoding: UTF-8
#
# FPM Recipe:: python-certifi
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

require 'fpm/cookery/recipe'

# A FPM Cookery recipe for the Certifi Python module.
#
# @author Jonathan Hartman <jonathan.hartman@socrata.com>
class PythonCertifi < FPM::Cookery::PythonRecipe
  name 'certifi'

  version ENV['CERTIFI_VERSION']
  revision ENV['CERTIFI_REVISION']

  description 'The Certifi module for Python'
  homepage 'https://pypi.python.org/pypi/certifi'
  maintainer 'Jonathan Hartman <jonathan.hartman@socrata.com>'
  vendor 'Socrata, Inc.'

  license 'Apache, version 2.0'

  build_depends %w(python python-pip)

  depends %w(python)

  cmd = "python -c 'from distutils.sysconfig import get_python_lib; " \
        "print get_python_lib()'"
  fpm_attributes[:python_install_lib] = `#{cmd}`
end

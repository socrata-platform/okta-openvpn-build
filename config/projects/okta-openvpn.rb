#
# Copyright 2016 YOUR NAME
#
# All Rights Reserved.
#

name "okta-openvpn"
maintainer "CHANGE ME"
homepage "https://CHANGE-ME.com"

# Defaults to C:/okta-openvpn on Windows
# and /opt/okta-openvpn on all other platforms
install_dir "#{default_root}/#{name}"

build_version Omnibus::BuildVersion.semver
build_iteration 1

# Creates required build directories
dependency "preparation"

# okta-openvpn dependencies/components
# dependency "somedep"

# Version manifest file
dependency "version-manifest"

exclude "**/.git"
exclude "**/bundler/git"

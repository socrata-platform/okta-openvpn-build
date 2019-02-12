# frozen_string_literal: true

describe directory('/etc/openvpn') do
  its(:owner) { should eq('root') }
  its(:group) { should eq('root') }
  its(:mode) { should cmp('0755') }
end

%w[
  README
  client.conf
  loopback-client
  loopback-server
  server.conf
  static-home.conf
  static-office.conf
  tls-home.conf
  tls-office.conf
  xinetd-client-config
  xinetd-server-config
].each do |conf|
  describe file(File.join('/etc/openvpn/sample_files', conf)) do
    it { should exist }
  end

  describe file(File.join('/etc/openvpn/okta_openvpn.ini')) do
    it { should exist }
  end

  describe file(File.join('/opt/openvpn/embedded/sample_files', conf)) do
    it { should exist }
    its(:owner) { should eq('root') }
    its(:group) { should eq('root') }
    its(:mode) { should cmp('0644') }
  end
end

%w[
  firewall.sh
  home.up
  office.up
  openvpn-shutdown.sh
  openvpn-startup.sh
].each do |conf|
  describe file(File.join('/etc/openvpn/sample_files', conf)) do
    it { should exist }
  end

  describe file(File.join('/opt/openvpn/embedded/sample_files', conf)) do
    it { should exist }
    its(:owner) { should eq('root') }
    its(:group) { should eq('root') }
    its(:mode) { should cmp('0755') }
  end
end

describe directory('/etc/openvpn/sample_files') do
  it { should exist }
  its(:link_path) do
    should eq('/opt/openvpn/embedded/sample_files')
  end
end

describe directory('/usr/lib/openvpn') do
  it { should exist }
  its(:link_path) do
    should eq('/opt/openvpn/embedded/lib/openvpn')
  end
end

describe directory('/usr/lib/openvpn/plugins/okta') do
  it { should exist }
end

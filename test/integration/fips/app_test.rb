# frozen_string_literal: true

describe package('openvpn') do
  it { should be_installed }
end

describe file('/usr/sbin/openvpn') do
  it { should exist }
  its(:link_path) { should eq('/opt/openvpn/embedded/sbin/openvpn') }
end

describe command('ldd /usr/sbin/openvpn') do
  %w[
    linux-vdso
    liblzo2
    libssl
    libcrypto
    libdl
    libc
    /lib64/ld-linux-x86-64
  ].each do |flag|
    its(:stdout) { should include(flag) }
  end
end

%w[
  /opt/openvpn
  /opt/openvpn/embedded
  /opt/openvpn/embedded/sample_files
].each do |d|
  describe directory(d) do
    it { should exist }
    its(:owner) { should eq('root') }
    its(:group) { should eq('root') }
    its(:mode) { should cmp('0755') }
  end
end

describe command('/opt/openvpn/embedded/bin/openssl md5 /etc/passwd') do
  its(:exit_status) { should eq(0) }
  its(:stdout) { should include('MD5(/etc/passwd)=') }
end

describe command('openvpn --version') do
  its(:stdout) { should match(/OpenSSL 1\.0\.2[a-z]-fips/) }
end

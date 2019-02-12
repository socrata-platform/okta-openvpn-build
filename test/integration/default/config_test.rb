describe directory('/usr/lib/openvpn') do
  it { should exist }
end

describe directory('/usr/lib/openvpn/plugins/okta') do
  it { should exist }
end

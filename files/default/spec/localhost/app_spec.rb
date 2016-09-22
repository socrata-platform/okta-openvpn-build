# Encoding: UTF-8

require_relative '../spec_helper'

describe 'okta-openvpn::app' do
  describe package('okta-openvpn') do
    it 'is installed' do
      expect(subject).to be_installed
    end
  end

  %w(
    /etc/openvpn/okta_openvpn.ini
    /usr/lib/openvpn/plugins/okta/okta_openvpn.py
  ).each do |f|
    describe file(f) do
      it 'exists' do
        expect(subject).to be_file
      end
    end
  end

  %w(M2Crypto urllib3 certifi).each do |d|
    describe file(File.join('/usr/lib/openvpn/plugins/okta', d)) do
      it 'exists' do
        expect(subject).to be_directory
      end
    end
  end
end

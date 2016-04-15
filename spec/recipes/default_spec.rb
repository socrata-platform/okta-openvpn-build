# Encoding: UTF-8

require_relative '../spec_helper'

describe 'okta-openvpn-build::default' do
  let(:platform) { { platform: 'ubuntu', version: '14.04' } }
  let(:runner) { ChefSpec::SoloRunner.new(platform) }
  cached(:chef_run) { runner.converge(described_recipe) }

  before(:each) do
    allow(OktaOpenvpnBuild::Helpers).to receive(:package_file)
      .and_return('/tmp/oo.pkg')
    allow(Kernel).to receive(:load).and_call_original
    allow(Kernel).to receive(:load)
      .with(%r{okta-openvpn-build/libraries/helpers\.rb}).and_return(true)
  end

  %w(_build _verify _deploy).each do |r|
    it "runs the '#{r}' recipe" do
      expect(chef_run).to include_recipe("okta-openvpn-build::#{r}")
    end
  end
end

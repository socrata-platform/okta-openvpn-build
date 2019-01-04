# frozen_string_literal: true

require_relative '../spec_helper'

describe 'okta-openvpn-build::_verify' do
  before do
    allow(OktaOpenvpnBuild::Helpers).to receive(:package_file)
      .and_return('/tmp/oo.pkg')
    allow(Kernel).to receive(:load).and_call_original
    allow(Kernel).to receive(:load)
      .with(%r{okta-openvpn-build/libraries/helpers\.rb}).and_return(true)
  end

  shared_examples_for 'any platform' do
    it { is_expected.to install_chef_gem('serverspec') }
    it { is_expected.to create_remote_directory('/tmp/spec') }

    it do
      is_expected.to run_execute(
        '/opt/chef/embedded/bin/rspec */*_spec.rb -f d'
      ).with(cwd: '/tmp/spec')
    end
  end

  context 'Ubuntu' do
    platform 'ubuntu'

    it_behaves_like 'any platform'

    it do
      is_expected.to install_dpkg_package('okta-openvpn')
        .with(package_name: '/tmp/oo.pkg')
    end
  end

  context 'CentOS' do
    platform 'centos'

    it_behaves_like 'any platform'

    it do
      is_expected.to install_rpm_package('okta-openvpn')
        .with(package_name: '/tmp/oo.pkg')
    end
  end
end

# frozen_string_literal: true

require_relative '../spec_helper'

describe 'okta-openvpn-build::_bintray' do
  platform 'ubuntu'

  shared_examples_for 'any attribute set' do
    it { is_expected.to_not install_chef_gem('packagecloud-ruby') }
  end

  context 'default attributes' do
    it_behaves_like 'any attribute set'

    it { is_expected.to_not run_ruby_block('Push artifacts to PackageCloud') }
  end

  context 'an overridden artifact publishing attribute' do
    default_attributes['okta_openvpn_build']['publish_artifacts'] = true

    it_behaves_like 'any attribute set'

    it { is_expected.to_not run_ruby_block('Push artifacts to PackageCloud') }
  end

  context 'bintray template' do
    it 'does not create' do
      expect(chef_run).to_not create_template('/tmp/fpm-recipes/okta-openvpn/pkg/okta-openvpn-fips.json')
    end
  end

  context 'bintray template' do
    default_attributes['okta_openvpn_build']['publish_artifacts'] = true
    it 'does create when publish_artifacts is true' do
      expect(chef_run).to create_template('/tmp/fpm-recipes/okta-openvpn/pkg/okta-openvpn-fips.json')
    end
  end
end

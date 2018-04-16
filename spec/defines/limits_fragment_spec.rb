require 'spec_helper'

describe 'limits::fragment' do
  on_supported_os.each do |os, default_facts|
    let(:facts) do
      default_facts
    end

    context "on #{os}" do
      describe 'when no $list param it should not compile and raise error' do
        let(:title) { 'blah' }

        it { is_expected.to compile.and_raise_error(/limits::fragment must specify \$list\./) }
      end

      describe 'when using RedHat 99, this should fail with a custom message' do
        let(:title) { 'blah' }
        let(:facts) do
          default_facts.merge({
            :operatingsystemmajrelease => '99',
          })
        end

        it { is_expected.to compile.and_raise_error(/This module 'limits' does not currently support RedHat '99'/) }
      end

      describe 'when ::osfamily => foo, this should fail with a custom error message' do
        let(:title) { 'blah' }
        let(:facts) do
          default_facts.merge({
            :osfamily => 'foo',
          })
        end

        it { is_expected.to compile.and_raise_error(/This module 'limits' does not currently support osfamily 'foo'/) }
      end

      describe 'when providing $list' do
        let(:title) { 'foobar' }
        let(:params) do
          {
            :list => [
                      '* soft nofile 2048',
                      '* hard nofile 2048',
                     ]
          }
        end

        let(:expected_content) do
          <<-EOS
# This file is being maintained by Puppet.
# DO NOT EDIT
* soft nofile 2048
* hard nofile 2048
          EOS
        end

        it do
          is_expected.to contain_limits__fragment('foobar').with({
            :ensure => 'file',
            :list   => params[:list],
          })
        end

        it do
          is_expected.to contain_file('/etc/security/limits.d/foobar.conf').with({
            :ensure => 'file',
            :owner  => 'root',
            :group  => 'root',
            :mode   => '0644',
            :content => expected_content,
          })
        end
      end
    end
  end
end

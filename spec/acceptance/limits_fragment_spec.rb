require 'spec_helper_acceptance'

describe 'limits::fragment' do
  it 'should work with no errors' do
    pp = <<-EOS
      limits::fragment { 'someuser':
        list => [
          'someuser soft nofile 2048',
          'someuser hard nofile 2048',
        ]
      }
    EOS

    # run it twice, to test idempotency
    apply_manifest(pp, :catch_failures => true)
    apply_manifest(pp, :catch_changes  => true)
  end

  describe file('/etc/security/limits.d/someuser.conf') do
    let(:expected_content) do
      <<-EOS
# This file is being maintained by Puppet.
# DO NOT EDIT
someuser soft nofile 2048
someuser hard nofile 2048
      EOS
    end
    it { is_expected.to be_file }
    it { is_expected.to exist }
    it { is_expected.to be_mode '644' }
    it { is_expected.to be_owned_by 'root' }
    it { is_expected.to be_grouped_into 'root' }
    its(:content) do
      is_expected.to eq expected_content
    end
  end

  describe 'when ensure=absent' do
    it 'should work with no errors' do
      pp = <<-EOS
        limits::fragment { 'someuser':
          ensure => 'absent',
          list   => [
            'someuser soft nofile 2048',
            'someuser hard nofile 2048',
          ]
        }
      EOS

      # run it twice, to test idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes  => true)
    end

    describe file('/etc/security/limits.d/someuser.conf') do
      it { is_expected.to_not exist }
    end
  end
end

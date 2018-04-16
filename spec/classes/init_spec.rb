require 'spec_helper'

describe 'limits' do

  on_supported_os.each do |os, default_facts|
    let(:facts) do
      default_facts
    end

    context "on #{os}" do
      context 'with defaults for all parameters' do
        it { should contain_class('limits') }
      end
    end
  end
end

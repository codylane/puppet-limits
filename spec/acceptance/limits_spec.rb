require 'spec_helper_acceptance'

describe 'limits' do
  it 'should work with no errors' do
    pp = <<-EOS
      include ::limits
    EOS

    # run it twice, to test idempotency
    apply_manifest(pp, :catch_failures => true)
    apply_manifest(pp, :catch_changes  => true)
  end
end

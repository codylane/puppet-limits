source "http://rubygems.org"

ENV['PUPPET_VERSION'].nil? ? puppetversion = ['~> 5.0'] : puppetversion = ENV['PUPPET_VERSION'].to_s

group :test do
  gem "puppetlabs_spec_helper", :require => false
  gem "puppet-lint", :require => false
  gem "beaker-puppet_install_helper", :require => false
  gem "beaker_spec_helper", :require => false
  gem "beaker-hiera", :require => false
  gem "simplecov", :require => false
  gem "puppet_facts", :require => false
  gem "json", :require => false
  gem "beaker-rspec", :require => false
  gem "serverspec", :require => false
  gem "rspec-puppet-facts", :require => false
  gem "rspec", :require => false
  gem "mocha", :require => false
  gem "mcollective-test", :require => false
  gem "metadata-json-lint", :require => false
  gem "semantic_puppet", :require => false

  mcollective_version = ENV['MCOLLECTIVE_GEM_VERSION']
  if mcollective_version
    gem 'mcollective-client', mcollective_version, :require => false
  else
    gem 'mcollective-client', :require => false
  end
end

gem "puppet", puppetversion, :require => false, :groups => [:test]

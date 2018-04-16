require 'beaker-rspec'
require 'beaker_spec_helper'
require 'beaker/puppet_install_helper'
require 'json'
require 'yaml'
include BeakerSpecHelper

# https://github.com/puppetlabs/beaker-puppet_install_helper
run_puppet_install_helper

def load_hiera_config module_root
  c = YAML.load_file("#{module_root}/spec/fixtures/hiera.yaml")
  return c
end

RSpec.configure do |c|

  # Project root
  module_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))
  metadata_content = File.read(File.join(module_root, 'metadata.json'))
  metdata_hash = JSON.load(metadata_content)
  module_name = metdata_hash['name'].split('-').last

  puts "module_root='#{module_root}'"
  puts "module_name='#{module_name}'"

  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    hosts.each do |host|
      copy_module_to(host, :source => module_root, :module_name => module_name)

      if Dir.exists?("#{module_root}/spec/fixtures/hieradata")
        copy_hiera_data_to(host, "#{module_root}/spec/fixtures/hieradata")
      end

      # Ensure that the git package is installed (RedHat-specific package name)
      on host, puppet('apply -e "package { \'epel-release\': ensure => installed }"')

      if fact('osfamily') == 'RedHat'
        if fact('operatingsystemmajrelease') =~ %r{7}
          shell("rpm -q puppet5-release || yum -y install 'https://yum.puppetlabs.com/puppet5/puppet5-release-el-7.noarch.rpm'")
        elsif fact('operatingsystemmajrelease') =~ %r{6}
          shell("rpm -q puppet5-release || yum -y install 'https://yum.puppetlabs.com/puppet5/puppet5-release-el-6.noarch.rpm'")
        else
          shell("rpm -q puppet5-release || yum -y install 'https://yum.puppetlabs.com/puppet5/puppet5-release-el-5.noarch.rpm'")
        end
      end

      on host, puppet('apply -e "package { \'puppet-agent\': ensure => latest }"')
      on host, puppet('apply -e "package { \'git\': ensure => installed }"')
      on host, puppet('apply -e "package { \'rsync\': ensure => installed }"')
      on host, puppet('module install --force puppetlabs-stdlib --version 4.25.1')

      # https://github.com/camptocamp/beaker_spec_helper
      BeakerSpecHelper::spec_prep(host)
    end
  end
end

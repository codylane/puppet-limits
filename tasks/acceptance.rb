require_relative "helpers"

desc "Acceptance tests"
namespace :acceptance do

  task :tests do
     set_provisioned_env(has_been_provisioned)
     Rake::Task[:beaker].invoke

     File.write($PROVISIONED_FILENAME, '')
  end

end

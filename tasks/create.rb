require_relative "helpers"

desc "Starts up the VM, provisions and keeps it running so you can run more tests"
task :create do
    ENV['BEAKER_destroy'] = 'no'

   Rake::Task[:validate].invoke
   Rake::Task[:spec].invoke
   Rake::Task[:beaker].invoke

   File.write($PROVISIONED_FILENAME, '')
end

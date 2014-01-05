require 'rake'
require 'rake/testtask'

# Allows us to run all test using 'rake test'
# Files in /lib are added to the load PATH by default, which means we can require
# any program files at the top of the test/test helper and ruby is able to find them
Rake::TestTask.new(:test) do |t|

  # Adds the /spec directory to the load PATH. Means we can use require 
  # test_helper at the top of each test file and ruby is able to find it
  t.libs << 'spec'

  # Pattern to find the test files to run
  t.pattern = 'spec/**/*_spec.rb'
end
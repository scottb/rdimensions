require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = 'rdimensions'
    gemspec.summary = 'Rudimentary access to Dimensions Metadata'
    gemspec.description = 'Rudimentary access to Dimensions Metadata'
    gemspec.email = 'scottb@brickner.net'
    gemspec.homepage = 'http://github.com/scottb/rdimensions'
    gemspec.authors = ['Scott Brickner']
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts 'Jewler not available. Install it with: sudo gem install jeweler'
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each {|ext| load ext }

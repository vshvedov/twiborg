options = {}
ARGV.options do |opts|

  opts.on( "-e", "--environment ENVIRONMENT", String,
           "The Rails Environment to run under." ) do |environment|
    options[:environment] = environment
  end

  opts.parse!
end

RAILS_ENV = options[:environment] || 'development'  

puts '-initializing'
require File.dirname(__FILE__) + '/../config/environment.rb'

if RAILS_ENV == "development" or RAILS_ENV == "test"
  SLEEP_TIME = 10
else
  SLEEP_TIME = 600
end

loop do
  puts '-run'
  Keyword.periodic_search.size
  puts '-sleep'
  sleep(SLEEP_TIME)
end

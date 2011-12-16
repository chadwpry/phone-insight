$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'rspec'

require 'phone-insight'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.before do
  end
end

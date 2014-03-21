ENV['RACK_ENV'] = 'test'

require_relative '../app.rb'

# recursively require all model files
Dir[Dir.pwd + "/models/**/*.rb"].each { |f| require f }

require 'rack/test'
require 'rspec'
require 'capybara/rspec'
require 'webmock/rspec'

RSpec.configure do |config|
  config.include Rack::Test::Methods

  def app() App end

  Capybara.app = app

  WebMock.disable_net_connect!(allow_localhost: true)
end

require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra-initializers'

module PhoneInsight
  class Application < Sinatra::Base
    enable :logging, :sessions
    enable :dump_errors, :show_exceptions if development?

    register Sinatra::Initializers

    configure :development do
      register Sinatra::Reloader
    end

    configure :production do
      require 'newrelic_rpm'
    end

    use Rack::Logger
    use Rack::Session::Cookie

    helpers PhoneInsight::TwilioHelper

    get "/" do
      haml :index
    end

    get "/api/twilio/call" do
      TwilioHelper.greeting
    end
  end
end

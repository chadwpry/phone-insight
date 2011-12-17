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

    helpers PhoneInsight::Helpers::TwilioHelper

    get "/" do
      haml :index
    end

    get "/cheryl" do
      TWILIO_CLIENT.account.calls.create(:from => TWILIO["from"], :to => '+1646-552-1776', :url => 'http://phone-insight.heroku.com/api/twilio/cheryl')
    end

    post "/api/twilio/cheryl" do
      content_type :xml
      Helpers::TwilioHelper.cheryl
    end

    post "/api/twilio/call" do
      content_type :xml
      Helpers::TwilioHelper.greeting
    end
  end
end


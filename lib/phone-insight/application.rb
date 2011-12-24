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

    get "/:number/:name" do
      require 'cgi'
      url = "http://phone-insight.heroku.com/api/twilio/personal?url=#{CGI.escape(params[:url] || "http://phone-insight.heroku.com/clips/aqua-teen-hunger-force.mp3")}"
      TWILIO_CLIENT.account.calls.create({
        :from => TWILIO["from"], :to => "+#{params[:number]}",
        :url => url
      })
      haml :"number/name"
    end

    post "/api/twilio/personal" do
      content_type :xml
      erb :"twilio/play_a_clip", :locals => {
        :clip => params[:url]
      }
#      Helpers::TwilioHelper.personal
    end

    post "/api/twilio/call" do
      content_type :xml
      Helpers::TwilioHelper.greeting
    end
  end
end


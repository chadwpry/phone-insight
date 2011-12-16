require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra-initializers'

module PhoneInsight
  class Application < Sinatra::Base
    register Sinatra::Initializers

    configure :development do
      register Sinatra::Reloader
    end

    configure :production do
      require 'newrelic_rpm'
    end

    get "/" do
      haml :index
    end
  end
end


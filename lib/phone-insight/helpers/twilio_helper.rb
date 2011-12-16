require 'yaml'

module PhoneInsight
  module TwilioHelper
    def greeting
      "config/twilio/messages/greeting.xml"
    end

    def load_response(path)
      YAML.load_file path
    end
  end
end

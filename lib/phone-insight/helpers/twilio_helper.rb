require 'yaml'

module PhoneInsight
  module Helpers
    module TwilioHelper
      def self.greeting
        load_xml_response "config/twilio/messages/greeting.xml"
      end

      def load_response(path)
        YAML.load_file path
      end
    end
  end
end

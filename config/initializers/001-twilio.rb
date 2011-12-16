require 'yaml'
require 'twilio-ruby'

# put your own account credentials here:
TWILIO = YAML.load_file("config/twilio.yml")

unless TWILIO
  TWILIO = {
    :account_sid => ENV["TWILIO_ACCOUNT_SID"],
    :auth_token  => ENV["TWILIO_AUTH_TOKEN"],
    :from        => ENV["TWILIO_FROM_NUMBER"],
    :url         => ENV["TWILIO_CALL_URL"]
  }
  TWILIO_CALL_OPTIONS = {
    :from => ENV["TWILIO_FROM_NUMBER"], :url => ENV["TWILIO_CALL_URL"]
  }
end

TWILIO_CLIENT = Twilio::REST::Client.new TWILIO[:account_sid], TWILIO[:auth_token]

## set up
#capability = Twilio::Util::Capability.new TWILIO[:account_sid], TWILIO[:auth_token]
#
## allow outgoing calls to an application
#capability.allow_client_outgoing 'AP295e8525cea4763d2839c07aaa6826ab'
#
## Generate the token string
#@token = capability.generate

#call_options = TWILIO_CALL_OPTIONS.merge({
#  :to => '+17734694402',
#  :url => "#{TWILIO_CALL_OPTIONS[:url]}?email_id=#{id}"
#})
#call_options.merge!(:to => phone_numbers.first) if options[:mode] == :production
#call = TWILIO_CLIENT.account.calls.create call_options


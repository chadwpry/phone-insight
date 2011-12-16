require "#{File.join(File.dirname(__FILE__), '..')}/spec_helper"

describe PhoneInsight::Helpers::TwilioHelper do
  describe "#greeting" do
    it "exists" do
      PhoneInsight::Helpers::TwilioHelper.should respond_to("greeting")
    end

    it "requires greeting xml file to exist" do
      File.should exist("config/twilio/messages/greeting.xml")
    end
  end
end

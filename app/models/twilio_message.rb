require 'builder'

class TwilioMessage
  def self.default_message
    builder = Builder::XmlMarkup.new
    xml = builder.Response do
      builder.Say("Thank you for calling Bucket. Bucket only supports SMS. To sign up to Bucket, subscribe to it from your BergCloud remote.")
    end
    xml
  end
end

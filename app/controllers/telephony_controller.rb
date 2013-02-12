class TelephonyController < ApplicationController
  def show
    render :xml => TwilioMessage.default_message
  end
end

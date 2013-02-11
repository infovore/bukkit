class ActivationsController < ApplicationController
  def create
    @account = Account.find_by_phone_number(params[:phone_number])
    begin
      @account.activate(params[:activation_code])
      TWILIO_CLIENT.account.sms.messages.create(:from => ENV['TWILIO_NUMBER'],
                                                :to => @account.phone_number,
                                                :body => "Thanks for signing up to Bukkit! You can now text to-do items to this number.")
      redirect "#{params[:return_url]}?config[auth_token]=#{@account.auth_token}"
    rescue AlreadyActivatedError
      render :text => "This account is already active."
    rescue ActivationError
      render :text => "Uh-oh."
    end
  end
end

class ActivationsController < ApplicationController
  def create
    @account = Account.find_by_phone_number(params[:phone_number])
    begin
      @account.activate(params[:activation_code])
      render :text => "Your account is now active. Your auth code is #{@account.auth_token}. Now, I would return you to #{params[:return_url]}"
    rescue AlreadyActivatedError
      render :text => "This account is already active."
    rescue ActivationError
      render :text => "Uh-oh."
    end
  end
end

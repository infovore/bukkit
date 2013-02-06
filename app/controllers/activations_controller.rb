class ActivationsController < ApplicationController
  def show
    @account = Account.find_by_phone_number(params[:account_id])
  end

  def create
    @account = Account.find_by_phone_number(params[:account_id])
    begin
      @account.activate(params[:activation_code])
      render :text => "Your account is now active. Your auth code is #{@account.auth_token}"
    rescue AlreadyActivatedError
      render :text => "This account is already active."
    rescue ActivationError
      render :text => "Uh-oh."
    end
  end
end

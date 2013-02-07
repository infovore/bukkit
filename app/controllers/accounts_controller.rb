class AccountsController < ApplicationController
  def new
    @account = Account.new
    @return_url = params[:return_url]
  end

  def create
    @account = Account.create_from_raw_number(params[:phone_number])
    @return_url = params[:return_url]
    if @account.save
      render :activate
      #redirect_to account_activations_path(@account.phone_number)
    else 
      flash[:warning] = "There was a problem saving your number."
      render :new
    end
  end

  def activate
    @return_url = params[:return_url]
  end

end

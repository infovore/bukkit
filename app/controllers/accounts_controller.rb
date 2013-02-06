class AccountsController < ApplicationController
  def new
    @account = Account.new
  end

  def create
    @account = Account.create_from_raw_number(params[:phone_number])
    if @account.save
      redirect_to account_activations_path(@account.phone_number)
    else 
      flash[:warning] = "There was a problem saving your number."
      render :new
    end
  end

  def activate
    @account = Account.find(params[:id])
  end

end

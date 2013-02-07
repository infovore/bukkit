class ItemsController < ApplicationController
  protect_from_forgery :except => :create 
  
  def create
    # get the phone number
    @account = Account.find_by_phone_number(params["From"])
    if @account && @account.activated?
      Item.create(:account_id => @account.id,
                  :content => params["Body"])
      head :ok
    end
  end
end

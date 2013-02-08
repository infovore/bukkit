class ItemsController < ApplicationController
  layout "lp"
  protect_from_forgery :except => :create 

  def index
    @account = Account.find_by_auth_token(params[:auth_token])
    if @account && @account.items.any?
      @items = @account.items.undelivered
      @items.each {|i| i.mark_delivered!}
      # mark all items as seen! yes, that's right: it's a destructive get
      # method
      # this is how little printer works, deal with it.
    elsif @account
      head :no_content
      #render :text => "no items in your account"
    else
      render :text => "not found"
      #head :not_found
    end
  end

  def sample
    @items = [Item.new(:content => "Pick up milk"),
              Item.new(:content => "ring the doctor"),
              Item.new(:content => "25 push-ups today!")]
    render :index
  end
  
  def create
    # get the phone number
    @account = Account.find_from_twilio(params["From"])
    if @account && @account.activated?
      Item.create(:account_id => @account.id,
                  :content => params["Body"])
      head :ok
    end
  end
end

class ItemsController < ApplicationController
  layout "lp"
  protect_from_forgery :except => :create 

  def index
    @account = Account.find_by_auth_token(params[:auth_token])
    if @account && @account.items.to_be_delivered.any?
      fresh_when(:etag => (@account.auth_token + Time.now.utc.to_s))
      @items = @account.items.to_be_delivered
      unless params[:preview] == "true"
        @items.each {|i| i.mark_delivered!}
      end
      # mark all items as seen! yes, that's right: it's a destructive get
      # method
      # this is how little printer works, deal with it.
    elsif @account
      fresh_when(:etag => (@account.auth_token + Time.now.utc.to_s))
      head :no_content
    else
      fresh_when(:etag => Time.now.utc.to_s)
      head :bad_request
    end
  end

  def sample
    @items = [Item.new(:content => "Pick up milk"),
              Item.new(:content => "ring the doctor about the horrible rash on my thigh"),
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

class Item < ActiveRecord::Base
  belongs_to :account
  attr_accessible :content, :account_id

  scope :delivered, where("delivered_at IS NOT NULL")
  scope :undelivered, where(:delivered_at => nil)
end

class Item < ActiveRecord::Base
  belongs_to :account
  attr_accessible :content, :account_id
end

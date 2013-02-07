class Item < ActiveRecord::Base
  belongs_to :account
  attr_accessible :content
end

class Item < ActiveRecord::Base
  belongs_to :account
  attr_accessible :content, :account_id, :delivered_at

  scope :delivered, where("delivered_at IS NOT NULL")
  scope :undelivered, where(:delivered_at => nil)

  def mark_delivered!
    self.delivered_at = Time.now
    self.save!
  end
end

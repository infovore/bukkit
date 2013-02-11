class Item < ActiveRecord::Base
  belongs_to :account
  attr_accessible :content, :account_id, :delivered_at

  scope :delivered, where("delivered_at IS NOT NULL")
  scope :to_be_delivered, lambda {
    where("delivered_at IS NULL or (delivered_at < ? AND delivered_at >= ?)", Time.now - 1.hour, Time.now - 24.hours)
  }
  scope :undelivered, where("delivered_at IS NULL")

  def mark_delivered!
    self.delivered_at = Time.now
    self.save!
  end
end

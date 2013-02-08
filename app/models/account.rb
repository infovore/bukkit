require 'bcrypt'

class ActivationError < StandardError; end
class AlreadyActivatedError < StandardError; end
class Account < ActiveRecord::Base
  has_many :items, :dependent => :destroy

  attr_accessible :phone_number
  before_create :generate_activation_code
  before_create :cannot_have_same_number_as_activated_account

  scope :activated, :conditions => "activated_at IS NOT NULL"

  validates_presence_of :phone_number

  class << self
    def create_from_raw_number(number)
      processed_number = PhoneNumber.from_raw_number(number)
      create(:phone_number => processed_number)
    end

    def find_from_twilio(twilio_number)
      n = twilio_number.gsub("+","")
      find_by_phone_number(n)
    end
  end

  def cannot_have_same_number_as_activated_account
    if Account.where("phone_number = ? AND activated_at IS NOT NULL", phone_number).any?
      errors.add(:phone_number, "That phone number is already in use.")
    end
  end

  def activate(entered_code)
    raise AlreadyActivatedError if activated?
    if entered_code == activation_code
      self.activated_at = Time.now
      self.auth_token = self.generate_auth_token
      self.save
    else
      raise ActivationError
    end
  end

  def activated?
    !activated_at.nil?
  end

  protected

  def generate_auth_token
    encrypted = BCrypt::Password.create(phone_number + activated_at.to_s)
  end

  private

  def generate_activation_code
    arr = []
    until(!arr.empty? && !Account.find_by_activation_code(arr.join)) do
      arr = []
      5.times { arr << rand(10) }
    end
    self.activation_code = arr.join
  end

end

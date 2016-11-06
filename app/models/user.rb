class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :account_type, presence: true

  has_secure_password
  has_many :activities
  has_many :properties_for_sale, class_name: 'Property', foreign_key: 'agent_id'
  has_many :properties_owned, class_name: 'Property', foreign_key: 'resident_id'

  after_initialize :ensure_token

  def self.generate_token
    SecureRandom::urlsafe_base64
  end

  def reset_token!
    self.token = self.class.generate_token
    self.save!
    self.token
  end

  private

  def ensure_token
    self.token ||= self.class.generate_token
  end
end

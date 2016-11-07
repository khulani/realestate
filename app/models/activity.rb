class Activity < ApplicationRecord
  validates :event, presence: true
  validates :date, presence: true
  validates :user_id, presence: true

  belongs_to :user, optional: true
end

class Property < ApplicationRecord
  validates :name, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :status, presence: true
  validates :agent_id, presence: true

  belongs_to :agent, class_name: 'User', foreign_key: 'agent_id', optional: true
  belongs_to :resident, class_name: 'User', foreign_key: 'resident_id', optional: true

  def get_operations user
    operations = []
    operations << 'delete' if user.account_type == 'admin' || user.id == agent_id
    operations << 'release' if user.id == resident_id
    operations << 'buy' if status == 'for sale'
    operations << 'rent' if status == 'for rent'
    operations
  end
end

class Property < ApplicationRecord
  belongs_to :agent, class_name: 'User', foreign_key: 'agent_id'
  belongs_to :resident, class_name: 'User', foreign_key: 'resident_id', optional: true
end

require 'rails_helper'

RSpec.describe Property, type: :model do
  context '#create' do
    it 'creates new Property given valid data' do
      count = Property.count
      property = Property.create(
        name: "San Jose Diridon Station",
        street: "65 Cahill St",
        city: "San Jose",
        state: "CA",
        latitude: 37.329875,
        longitude: -121.902517,
        status: "rented",
        agent_id: 3,
      )
      expect(property.valid?).to be_truthy
      expect(Property.count).to eql (count + 1)
    end

    it 'does not create Property with missing data' do
      expected_errors = [
        "Name can't be blank", "Street can't be blank", "City can't be blank",
        "State can't be blank", "Status can't be blank", "Agent can't be blank"
      ]
      property = Property.create

      expect(property.valid?).to be_falsy
      expect(property.errors.full_messages).to eql expected_errors
    end
  end
end

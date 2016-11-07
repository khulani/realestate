require 'rails_helper'

RSpec.describe Activity, type: :model do
  context '#create' do
    it 'creates new Activity given valid data' do
      count = Activity.count
      activity = Activity.create(event: 'User logged in: customer1', user_id: 12, date: Time.now)
      expect(activity.valid?).to be_truthy
      expect(Activity.count).to eql (count + 1)
    end

    it 'does not create Activity with missing data' do
      activity = Activity.create
      expect(activity.valid?).to be_falsy
      expect(activity.errors.full_messages).to eql ["Event can't be blank", "Date can't be blank", "User can't be blank"]
    end
  end
end

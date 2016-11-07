require 'rails_helper'

RSpec.describe User, type: :model do
  context '#create' do
    it 'creates new User given valid data' do
      count = User.count
      user = User.create(username: 'username', password: 'password', account_type: 'customer')
      expect(user.valid?).to be_truthy
      expect(User.count).to eql (count + 1)
    end

    it 'generates an authentication token on creation' do
      user = User.create(username: 'username', password: 'password', account_type: 'customer')
      expect(user.token).to_not be_nil
    end

    it 'does not create User with missing data' do
      user = User.create
      expect(user.valid?).to be_falsy
      expect(user.errors.full_messages).to eql ["Username can't be blank", "Account type can't be blank", "Password can't be blank"]
    end
  end

  context '#reset_token!' do
    it 'generates a new token' do
      user = User.create(username: 'username', password: 'password', account_type: 'customer')
      token = user.token
      expect(user.reset_token!).to_not eql token
    end
  end
end

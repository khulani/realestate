require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  render_views

  describe 'GET index' do
    it 'provides a signup/login interface' do
      post :index
      expect(response.status).to be 200
      expect(response.body).to match 'Username'
      expect(response.body).to match 'Password'
      expect(response.body).to match 'Signup'
      expect(response.body).to match 'Login'
    end
  end

  describe 'POST login' do
    it 'logs in successfully with valid user credentials' do
      user = User.create(username: 'username', password: 'password', account_type: 'customer')
      process :login, method: :post, params: { username: 'username', password: 'password' }
      expect(response).to redirect_to user_path(user.id)
      expect(flash[:errors]).to_not be_present
    end
    it 'redirects back to the login screen given invalid user credentials' do
      process :login, method: :post, params: { username: 'username', password: 'password' }
      expect(response).to redirect_to users_path
      expect(flash[:errors]).to be_present
    end
    it 'tracks user activity' do
      user = User.create(username: 'username', password: 'password', account_type: 'customer')
      process :login, method: :post, params: { username: 'username', password: 'password' }
      expect(Activity.last.event).to eql "User logged in: #{user.username}"
    end
  end

  describe 'GET show' do
    it 'redirects to the login page if user is not logged in' do
      # get :show, params: { id: 1 }
      process :show, method: :get, params: { id: 1 }
      expect(response).to redirect_to users_path
    end
    it 'shows welcome screen with valid cookie' do
      user = User.create(username: 'username', password: 'password', account_type: 'customer')
      request.cookies['token'] = user.token
      process :show, method: :get, params: { id: 1 }
      expect(response.body).to match "Welcome, #{user.username}"
    end
  end

  describe 'DELETE logout' do
    it 'clears token and redirects to login page' do
      user = User.create(username: 'username', password: 'password', account_type: 'customer')
      request.cookies['token'] = user.token
      process :logout, method: :delete, params: { id: user.id }
      # delete :logout, id: user.id
      expect(response).to redirect_to users_path
      expect(response.cookies['token']).to be_nil
    end
  end
end

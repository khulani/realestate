class UsersController < ApplicationController
  before_action :login_status, except: [:index, :create, :login]

  def index
    @user = User.find_by(token: cookies[:token])
    redirect_to "/users/#{@user.id}" if @user
  end

  def create
    @user = User.create(create_params)
    if @user.valid?
      cookies[:token] = @user.token
      redirect_to "/users/#{@user.id}"
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to '/'
    end

  end

  def show
  end

  def destroy
    if @user.destroy
      flash[:errors] = ["Account '#{@user.username}' has been deleted."]
    else
      flash[:errors] = ["Unable to delete account '#{@user.username}'."]
    end
    redirect_to '/'
  end

  def create_params
    params.permit(:username, :password, :account_type)
  end

  def login
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      puts "hi"
      cookies[:token] = @user.token
      redirect_to "/users/#{@user.id}"
    else
      flash[:errors] = ["Invalid username and/or password."]
      redirect_to '/'
    end
  end

  def logout
    @user.reset_token!
    cookies.delete :token
    redirect_to '/'
  end
end

class UsersController < ApplicationController
  before_action :login_status, except: [:index, :create, :login]

  def index
    @user = User.find_by(token: cookies[:token])
    redirect_to "/users/#{@user.id}" if @user
  end

  def create
    @user = User.create(create_params)
    if @user.valid?
      @user.activities.create(event: "User created: #{@user.username}", date: Time.now)
      cookies[:token] = @user.token
      redirect_to "/users/#{@user.id}"
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to users_path
    end

  end

  def show
    respond_to do |format|
      format.html
      format.pdf do
        pdf = ReportPdf.new(@user)
        send_data pdf.render, filename: 'report.pdf', type: 'application/pdf', disposition: 'inline'
      end
    end
  end

  def destroy
    @user.activities.create(event: "User deleted: #{@user.username}", date: Time.now)
    if @user.destroy
      flash[:errors] = ["Account '#{@user.username}' has been deleted."]
    else
      flash[:errors] = ["Unable to delete account '#{@user.username}'."]
    end
    redirect_to users_path
  end

  def create_params
    params.permit(:username, :password, :account_type)
  end

  def login
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      cookies[:token] = @user.token
      @user.activities.create(event: "User logged in: #{@user.username}", date: Time.now)
      redirect_to "/users/#{@user.id}"
    else
      flash[:errors] = ["Invalid username and/or password."]
      redirect_to users_path
    end
  end

  def logout
    @user.activities.create(event: "User logged out: #{@user.username}", date: Time.now)
    @user.reset_token!
    cookies.delete :token
    redirect_to users_path
  end
end

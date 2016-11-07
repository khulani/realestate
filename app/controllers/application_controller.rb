class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception

  def access_status
    unless params[:auth_token] == 'Of04p3eLBO71fof2stHYIQ'
      render status: 401, json: { errors: ["Access not authorized. (Invalid 'token')"] }
    end
  end

  def login_status
    @user = User.find_by(token: cookies[:token])
    unless @user
      flash[:error] = ['Please log in.']
      redirect_to users_path
    end
  end
end

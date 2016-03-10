class UsersController < ApplicationController
  def index
  end
  # Registration method for register.html.erb

  def login
    if (params.has_key?(:user_name) && !params[:user_name].strip.empty?) &&
       (params.has_key?(:password) && !params[:password].strip.empty?)
      @user_name = params[:user_name].strip
      @password = params[:password].strip
      users = User.where(["user_name = ? and password = ?", @user_name, @password])
      if !users.empty?
        @user = users.first
        session[:id] = @user.id.to_s
        redirect_to '/welcome/do'
      else
        flash[:alert] = "Login unsuccessful"
        render 'index'
      end
    else
      # The registration page is rendered if the above conditions are not met.
      flash[:alert] = "Please enter credentials"
      render 'index'
    end
  end

end

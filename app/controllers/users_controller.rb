class UsersController < ApplicationController
  # Registration method for register.html.erb
  def register
    # This IF statement checks for empty user_name and password fields, and if they are not emtpy assigns the input to the corresponding variable.
    if (params.has_key?(:user_name) && !params[:user_name].strip.empty?) &&
       (params.has_key?(:password) && !params[:password].strip.empty?)
      user_name = params[:user_name].strip
      password = params[:password].strip
      full_name = params[:full_name].strip
      address = params[:address].strip
      city = params[:city].strip
      state = params[:state].strip
      postal_code = params[:postal_code].strip
      country = params[:country].strip
      email = params[:email].strip
      users = User.where(["user_name = ?", user_name])
      if users.empty?
        @user = User.new
        # Assigns each variable to its corresponding column in the user object and saves it.
        @user.user_name = user_name
        @user.password = password
        @user.full_name = full_name unless full_name.empty?
        @user.address = address unless address.empty?
        @user.city = city unless city.empty?
        @user.state = state unless state.empty?
        @user.postal_code = postal_code unless postal_code.empty?
        @user.country = country unless country.empty?
        @user.email = email unless email.empty?
        if params.has_key?(:phone1) && !params[:phone1].strip.empty?
          phone1 = params[:phone1].strip
          p1 = Phone.new
          p1.number = phone1
          @user.phones << p1
          p1.save
        end
        if params.has_key?(:phone2) && !params[:phone2].strip.empty?
          phone2 = params[:phone2].strip
          p2 = Phone.new
          p2.number = phone2
          @user.phones << p2
          p2.save
        end
        if params.has_key?(:phone3) && !params[:phone3].strip.empty?
          phone3 = params[:phone3].strip
          p3 = Phone.new
          p3.number = phone3
          @user.phones << p3
          p3.save
        end
        @user.save
        session[:id] = @user.id.to_s
        # Once the input fields have been saved to variables and assigned to the user object, the user is redirected to the confirmation page.
        redirect_to '/confirmation/do'
      else
        flash[:error] = "Username already exists"
        render 'register'
      end
    else
      # The registration page is rendered if the above conditions are not met.
      render 'register'
    end
  end

  def login
    if (params.has_key?(:user_name) && !params[:user_name].strip.empty?) &&
       (params.has_key?(:password) && !params[:password].strip.empty?)
      @user_name = params[:user_name].strip
      @password = params[:password].strip
      users = User.where(["user_name = ? and password = ?", @user_name, @password])
      if !users.empty?
        redirect_to '/welcome/do'
      else
        flash[:alert] = "Login unsuccessful"
        render 'register'
      end
    else
      # The registration page is rendered if the above conditions are not met.
      flash[:alert] = "Please enter credentials"
      render 'register'
    end
  end
end

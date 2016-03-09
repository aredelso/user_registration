class UsersController < ApplicationController
  def index
  end
  # Registration method for register.html.erb
  def register
    # This IF statement checks for empty user_name and password fields, and if they are not emtpy assigns the input to the corresponding variable.
    if (params.has_key?(:user_name) && !params[:user_name].strip.empty?) &&
       (params.has_key?(:password) && !params[:password].strip.empty?)
      @user_name = params[:user_name].strip
      @password = params[:password].strip
      full_name = params[:full_name].strip
      address = params[:address].strip
      city = params[:city].strip
      state = params[:state].strip
      postal_code = params[:postal_code].strip
      country = params[:country].strip
      email = params[:email].strip
      users = User.where(["user_name = ?", @user_name])
      if checker
        if users.empty?
          @user = User.new
          # Assigns each variable to its corresponding column in the user object and saves it.
          @user.user_name = @user_name
          @user.password = @password
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
          render 'users/index'
        end
      else
        render 'users/index'
      end
    else
      # The registration page is rendered if the above conditions are not met.
      flash[:blank_reg] = "Must enter a username and password."
      render 'users/index'
    end
  end

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
#As an internet user, only passwords that fullfill certain minimum requirements are accepted when i register.
  def checker
      if @user_name == @password
        @same_string = flash.now[:checker] = "User ID and password cannot be the same"
      end
      if @user_name.length < 6
        @long_user_name_string = flash.now[:checker] = "User ID must be 6 characters or longer"
      end
      if @password.length < 6
        @long_password_string = flash.now[:checker] = "Password must be at least 6 characters long"
      end
      # if @user_name.length < 6 && @password.length < 6
      #   @long_string = flash.now[:alert] = "User ID and Password must be 6 characters or longer"
      # end
      # elsif @user_name.length < 6 && @password.length >=6
      #   @long_string = flash.now[:alert] = "UserID must be 6 characters or longer"
      # elsif  @user_name.length >= 6 && @password.length < 6
      #   @long_string = flash.now[:alert] = "Password must be 6 characters or longer"
      # end
      if @user_name.include?("!") || @user_name.include?("#") || @user_name.include?("$")
        @not_contain_string = flash.now[:checker] = "User ID cannot contain these special characters: !$#"
      end
      if !@password.include?("!") && !@password.include?("#") && !@password.include?("$")
        @contains_string = flash.now[:checker] = "Password must contain at least one of these special characters: !$#"
      end
      if @same_string.nil? && @long_user_name_string.nil? && @long_password_string.nil? && @not_contain_string.nil? && @contains_string.nil?
        @valid_string = flash.now[:checker] = "User ID and password are valid"
      end
      # if @same_string.nil? && @long_user_name_string.nil? && @not_contain_string.nil?
      #   @valid_user_name_string = flash.now[:alert] = "Username is valid"
      # end
      # if @same_string.nil? && @long_password_string.nil? && @contains_string.nil?
      #   @valid_password_string = flash.now[:alert] = "Password is valid"
      # end
      # if !@valid_user_name_string.nil? && !@valid_password_string.nil?
      #   @valid_string = flash.now[:alert] = "Username and Password are valid"
      # end
    end
end

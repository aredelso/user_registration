class WelcomeController < ApplicationController
  def do
    if session[:id].nil?
      redirect_to '/logout/do'
    else
      @user = User.find(session[:id])
      @phones = Phone.where("user_id = ?", session[:id])
      if @phones.empty?
        flash[:no_phone] = "No Phones"
      end
    end
  end

  def logout
    @session_id = session[:id]
    @session_id = nil
    redirect_to '/logout/do'
  end
end

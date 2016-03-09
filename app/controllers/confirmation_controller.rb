class ConfirmationController < ApplicationController
  # finds the user by its ID that was just input from the html and assigns it to an instance variable.
  def do
    @user = User.find(session[:id])
  end
end

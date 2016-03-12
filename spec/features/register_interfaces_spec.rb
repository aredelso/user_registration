require 'rails_helper'

RSpec.feature "RegisterInterfaces", type: :feature do
  describe "Register" do
    it "should show the registration form" do
      visit '/register/do'
      expect(page).to have_content('Register')
    end

    it "should redirect to Login when link is clicked" do
      visit '/register/do'
      expect(page).to have_content("Register")
      click_link "Already have an account?"
      expect(current_path).to eq('/users/index')
      expect(page).to have_content('Log in')
    end

    it "should create a user" do
      visit '/register/do'
      create_a_user
      click_button 'Register'
      expect(current_path).to eq('/confirmation/do')
      expect(page).to have_content('Hello andrew!')
    end

    it "should go to the info page when button is clicked" do
      visit '/register/do'
      create_a_user
      click_button 'Register'
      expect(current_path).to eq('/confirmation/do')
      expect(page).to have_content('Hello andrew!')
      click_button 'Go To Profile'
      expect(current_path).to eq('/welcome/do')
      expect(page).to have_content('Hello andrew!')
    end

    it "should log a user out when the logout button is clicked" do
      visit '/register/do'
      create_a_user
      click_button 'Register'
      expect(current_path).to eq('/confirmation/do')
      expect(page).to have_content('Hello andrew!')
      click_button 'Go To Profile'
      expect(current_path).to eq('/welcome/do')
      expect(page).to have_content('Hello andrew!')
      click_button 'Logout'
      expect(current_path).to eq('/logout/do')
      expect(@session_id).to eq(nil)
    end
  end

  def create_a_user
    fill_in('user_name', :with => 'andrew')
    fill_in('password', :with => 'password!')
  end
end

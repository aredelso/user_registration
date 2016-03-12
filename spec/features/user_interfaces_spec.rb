require 'rails_helper'

RSpec.feature "UserInterfaces", type: :feature do
  describe "Login" do
    it "should show the Login form" do
      visit '/'
      expect(page).to have_content("Log in")
    end

    it "should go to the registration form when link is clicked" do
      visit '/'
      expect(page).to have_content("Log in")
      click_link "Not registered yet?"
      expect(current_path).to eq('/register/do')
      expect(page).to have_content('Register')
    end

    it "should display user info when a user logs in" do
      visit '/register/do'
      create_a_user
      click_button 'Register'
      visit '/'
      fill_in('user_name', :with => 'andrew')
      fill_in('password', :with => 'password!')
      click_button 'Log in'
      expect(current_path).to eq('/welcome/do')
      expect(page).to have_content('Hello andrew!')
      expect(page).to have_content('No Phones')
    end

    it "should display user info when a user logs in with phone number" do
      visit '/register/do'
      create_a_user_with_a_phone
      click_button 'Register'
      visit '/'
      fill_in('user_name', :with => 'andrew')
      fill_in('password', :with => 'password!')
      click_button 'Log in'
      expect(current_path).to eq('/welcome/do')
      expect(page).to have_content('Hello andrew!')
      expect(page).to have_content('1234567890')
    end

    it "should logout the user when logout button is clicked" do
      visit '/register/do'
      create_a_user
      click_button 'Register'
      visit '/'
      fill_in('user_name', :with => 'andrew')
      fill_in('password', :with => 'password!')
      click_button 'Log in'
      expect(current_path).to eq('/welcome/do')
      expect(page).to have_content('Hello andrew!')
      click_button 'Logout'
      expect(current_path).to eq('/logout/do')
      expect(page).to have_content('You are now logged out')
    end
  end

  def create_a_user
    fill_in('user_name', :with => 'andrew')
    fill_in('password', :with => 'password!')
  end

  def create_a_user_with_a_phone
    fill_in('user_name', :with => 'andrew')
    fill_in('password', :with => 'password!')
    fill_in('phone1', :with => '1234567890')
  end
end

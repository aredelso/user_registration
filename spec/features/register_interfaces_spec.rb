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
  end
end

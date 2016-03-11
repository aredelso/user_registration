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
  end
end

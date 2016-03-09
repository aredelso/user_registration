require 'rails_helper'

RSpec.feature "UserInterfaces", type: :feature do
  describe "Register" do
    it "should show the registration form" do
      visit '/'
      expect(page).to have_content("User Registration")
    end
  end
end

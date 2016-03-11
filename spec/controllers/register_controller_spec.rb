require 'rails_helper'

RSpec.describe RegisterController, type: :controller do

  describe "POST #create" do
    # it "returns http redirect" do
    #   post :create
    #   expect(response).to have_http_status(:redirect)
    # end

    it "should create a user" do
      create_a_user
      expect(User.first).to be_a(User)
      expect(User.first.user_name).to eq('andrew')
      expect(User.first.password).to eq('password!')
      expect(User.first.full_name).to be(nil)
      expect(User.first.address).to be(nil)
      expect(User.first.city).to be(nil)
      expect(User.first.state).to be(nil)
      expect(User.first.postal_code).to be(nil)
      expect(User.first.country).to be(nil)
      expect(User.first.email).to be(nil)
    end

    it "should create a user with all values" do
      create_a_user_with_all_values
      expect(User.first).to be_a(User)
      expect(User.first.user_name).to eq('andrew')
      expect(User.first.password).to eq('password!')
      expect(User.first.full_name).to eq('Andrew Edelson')
      expect(User.first.address).to eq('123 any street')
      expect(User.first.city).to eq('San Diego')
      expect(User.first.state).to eq('CA')
      expect(User.first.postal_code).to eq(92037)
      expect(User.first.country).to eq('Murica')
      expect(User.first.email).to eq('any@email.com')
    end

    it "should not create user if there is no password" do
      create_user_without_password
      expect(User.first).to be(nil)
    end

    it "should not create user if there is no username" do
      create_a_user_without_user_name
      expect(User.first).to be(nil)
    end

    it "should not create user if the password is invalid" do
      create_user_with_invalid_password
      expect(User.first).to be(nil)
    end
  end

  def create_a_user
    expect(User.first).to be(nil)
    post :create, user_name: 'andrew', password: 'password!'
  end

  def create_a_user_with_all_values
    expect(User.first).to be(nil)
    post :create, user_name: 'andrew', password: 'password!', full_name: 'Andrew Edelson', address: '123 any street', city: 'San Diego', state: 'CA', postal_code: '92037', country: 'Murica', email: 'any@email.com'
  end

  def create_user_without_password
    expect(User.first).to be(nil)
    post :create, user_name: 'andrew'
  end

  def create_a_user_without_user_name
    expect(User.first).to be(nil)
    post :create, password: 'andrew!'
  end

  def create_user_with_invalid_password
    expect(User.first).to be(nil)
    post :create, user_name: 'andrew', password: 'password'
  end

end

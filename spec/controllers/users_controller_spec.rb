require "rails_helper"

RSpec.describe UsersController, type: :controller do
  login_user
  let(:valid_attributes) {
    {user: {
      full_name: "Test User",
      email: "testuser@email.com",
      password: "password",
      password_confirmation: "password",
      role: :admin
    }}
  }

  describe "GET #index" do
    it "should render index" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "shoudld render new" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    it "shoudld create a new user with valid attributes" do
      post :create, params: valid_attributes
      expect(response).to redirect_to(users_path)
      expect(flash[:notice]).to be_present
    end

    it "should raise error when creating user with invalid attributes" do
      post :create, params: {user:{full_name: "Test User", email: "testemail"}}
      expect(assigns(:user).errors).to be_present
    end
  end
end
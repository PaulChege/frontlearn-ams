require "rails_helper"

RSpec.describe Users::SessionsController, type: :controller do
  set_devise_mapping

  let!(:user) {create(:user)}
  let(:valid_credntials) { 
    {
      user: {
        email: "test@email.com", 
        password: "password"
      }
    }
  }

  describe "GET #new" do
    it "should render login page" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    it "should login a user with valid credentials" do
      post :create, params: valid_credntials
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to be_present
    end

    it "should not login a user with invalid credentials" do
      post :create, params: {user: {email: "test@email.com", password: "wrongpassword"}}
      expect(flash[:alert]).to be_present
    end
  end
end
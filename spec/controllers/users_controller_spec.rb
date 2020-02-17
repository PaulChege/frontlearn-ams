# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  login_user

  let(:user) { create(:user) }
  let(:valid_attributes) do
    { user: {
      full_name: 'Test User',
      email: 'testuser@email.com',
      password: 'password',
      password_confirmation: 'password',
      role: :admin
    } }
  end

  describe 'GET #index' do
    it 'should render index' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'shoudld render new' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    it 'should add user record after creating user with valid attributes and redirect' do
      expect { post :create, params: valid_attributes }.to change(User, :count)
      expect(response).to redirect_to(users_path)
      expect(flash[:notice]).to be_present
    end

    it 'should raise error when creating user with invalid attributes' do
      post :create, params: { user: { full_name: 'Test User', email: 'test@email' } }
      expect(assigns(:user).errors.size).to be >= 1
    end
  end

  describe 'GET #edit' do
    it 'should render edit' do
      get :edit, params: { id: user.id }
      expect(response).to be_successful
    end
  end

  describe 'PUT #update' do
    it 'should update user with valid attributes' do
      put :update, params: { id: user.id, user: { full_name: 'Testing User' } }
      expect(response).to redirect_to(users_path)
      expect(flash[:notice]).to be_present
    end

    it 'it should raise error when updating user with invalid attributes' do
      put :update, params: { id: user.id, user: { full_name: '' } }
      expect(assigns(:user).errors.size).to be >= 1
    end
  end

  describe 'DELETE #destroy' do
    let(:delete_request) { delete :destroy, params: { id: user.id } }

    it 'should remove user record and redirect' do
      user
      expect { delete_request }.to change(User, :count)
      expect(response).to redirect_to(users_path)
      expect(flash[:notice]).to be_present
    end
  end
end

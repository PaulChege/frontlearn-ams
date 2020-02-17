# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SchoolsController, type: :controller do
  login_user

  let(:valid_attributes) do
    { school: { name: 'Culinary Arts' } }
  end
  let(:school) { create(:school) }

  describe 'GET #index' do
    it 'should render index' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'should render new' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    it 'shoudld create new new school with valid attributes' do
      post :create, params: valid_attributes
      expect(response).to redirect_to(schools_path)
      expect(flash[:notice]).to be_present
    end

    it 'should raise error when creating school with invalid attributes' do
      post :create, params: { school: { name: '' } }
      expect(assigns(:school).errors.size).to be == 1
    end
  end

  describe 'DELETE #destroy' do
    let(:delete_request) { delete :destroy, params: { id: school.id } }
    it 'should redirect after deleting a school' do
      delete_request
      expect(response).to redirect_to(schools_path)
      expect(flash[:notice]).to be_present
    end
    it 'should remove school record' do
      school
      expect { delete_request }.to change(School, :count)
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UnitsController, type: :controller do
  login_user
  let(:unit) { create(:unit) }

  describe 'GET #index' do
    it 'should render index' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'should render edit' do
      get :edit, params: { id: unit.id }
      expect(response).to be_successful
    end
  end

  describe 'PUT #update' do
    it 'should update unit with valid attributes' do
      put :update, params: {
        id: unit.id, unit: { code: 'CUL/01/01' }
      }
      expect(response).to redirect_to(units_path)
      expect(flash[:notice]).to be_present
    end

    it 'it should raise error when updating unit with invalid attributes' do
      put :update, params: {
        id: unit.id, unit: { code: '' }
      }
      expect(assigns(:unit).errors.size).to be == 1
    end
  end

  describe 'DELETE #destroy' do
    let(:delete_request) do
      delete :destroy, params: {
        id: unit.id
      }
    end

    it 'should redirect after deleting a unit' do
      delete_request
      expect(response).to redirect_to(units_path)
      expect(flash[:notice]).to be_present
    end

    it 'should remove unit record' do
      unit
      expect { delete_request }.to change(Unit, :count)
    end
  end
end

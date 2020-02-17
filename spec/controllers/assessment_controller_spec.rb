# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AssessmentsController, type: :controller do
  login_user
  let(:assessment) { create(:assessment) }
  let(:valid_attributes) do
    {
      assessment: {
        semester_month: 'Jan',
        semester_year: Time.now.year
      }
    }
  end

  describe 'GET #index' do
    it 'should render index' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    it 'shoudld create new assessment with valid attributes' do
      post :create, params: valid_attributes
      expect(response).to redirect_to(assessments_path)
      expect(flash[:notice]).to be_present
    end

    it 'should raise error when creating duplicate assessment' do
      post :create, params: { assessment: {
        semester_month: assessment.semester_month,
        semester_year: assessment.semester_year
      } }
      expect(assigns(:assessment).errors.size).to be == 1
    end
  end

  describe 'PUT #update' do
    let(:update_request) { put :update, params: { id: assessment.id } }
    it 'should toggle assessment status' do
      expect { update_request && assessment.reload }.to change { assessment.status }
      expect(response).to redirect_to(assessments_path)
      expect(flash[:notice]).to be_present
    end
  end

  describe 'DELETE #destroy' do
    it 'should remove assessment record and redirect' do
      assessment
      expect { delete :destroy, params: { id: assessment.id } }.to change(Assessment, :count)
      expect(response).to redirect_to(assessments_path)
      expect(flash[:notice]).to be_present
    end
  end
end

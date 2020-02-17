# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
  login_user
  let(:course) { create(:course) }
  let(:student) { create(:student) }
  let(:valid_attributes) do
    { student: {
      first_name: 'Test',
      last_name: 'User',
      email: 'testuser@email.com',
      mobile_number: '0711222333',
      course_id: course.id,
      intake_month: 'Jan',
      intake_year: Time.now.year
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
    it 'should add student record after creating user with valid attributes and redirect' do
      expect { post :create, params: valid_attributes }.to change(Student, :count)
      expect(response).to redirect_to(students_path)
      expect(flash[:notice]).to be_present
    end

    it 'should raise error when creating user with invalid attributes' do
      post :create, params: { student: { first_name: 'Test User', email: '' } }
      expect(assigns(:student).errors.size).to be >= 1
    end
  end

  describe 'GET #edit' do
    it 'should render edit' do
      get :edit, params: { id: student.id }
      expect(response).to be_successful
    end
  end

  describe 'PUT #update' do
    it 'should update student with valid attributes' do
      put :update, params: { id: student.id, student: { first_name: 'Jane' } }
      expect(response).to redirect_to(students_path)
      expect(flash[:notice]).to be_present
    end

    it 'it should raise error when updating student with invalid attributes' do
      put :update, params: { id: student.id, student: { first_name: '' } }
      expect(assigns(:student).errors.size).to be >= 1
    end
  end

  describe 'DELETE #destroy' do
    let(:delete_request) { delete :destroy, params: { id: student.id } }
    it 'should remove user record and redirect' do
      student
      expect { delete_request }.to change(Student, :count)
      expect(response).to redirect_to(students_path)
      expect(flash[:notice]).to be_present
    end
  end
end

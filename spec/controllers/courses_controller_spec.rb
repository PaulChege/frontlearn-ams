# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  login_user
  let(:school) { create(:school) }
  let(:course) { create(:course) }
  let(:valid_attributes) do
    {
      school_id: school.id,
      course: {
        name: 'Baking',
        level: 'Diploma'
      }
    }
  end

  describe 'GET #index' do
    it 'should render index' do
      get :index, params: { school_id: school.id }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'shoudld render new' do
      get :new, params: { school_id: school.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    it 'shoudld create new course with valid attributes' do
      post :create, params: valid_attributes
      expect(response).to redirect_to(school_courses_path)
      expect(flash[:notice]).to be_present
    end

    it 'should raise error when creating course with invalid attributes' do
      post :create, params: { school_id: school.id, course: { name: '' } }
      expect(assigns(:course).errors.size).to be == 1
    end
  end

  describe 'GET #edit' do
    it 'should render edit' do
      get :edit, params: { school_id: course.school.id, id: course.id }
      expect(response).to be_successful
    end
  end

  describe 'PUT #update' do
    it 'should update course with valid attributes' do
      put :update, params: {
        school_id: course.school.id, id: course.id, course: { name: 'Culinary Practices' }
      }
      expect(response).to redirect_to(school_courses_path)
      expect(flash[:notice]).to be_present
    end

    it 'it should raise error when updating course with invalid attributes' do
      put :update, params: {
        school_id: course.school.id, id: course.id, course: { name: '' }
      }
      expect(assigns(:course).errors.size).to be == 1
    end
  end

  describe 'DELETE #destroy' do
    let(:delete_request) do
      delete :destroy, params: {
        school_id: course.school.id, id: course.id
      }
    end

    it 'should remove course record and redirect' do
      course
      expect { delete_request }.to change(Course, :count)
      expect(response).to redirect_to(school_courses_path)
      expect(flash[:notice]).to be_present
    end
  end
end

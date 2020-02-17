# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Courses::UnitsController, type: :controller do
  login_user
  let(:course) { create(:course) }
  let(:unit) { create(:unit) }
  let(:course_unit) { create(:course_unit) }

  let(:valid_attributes) do
    {
      school_id: course.school.id,
      course_id: course.id,
      unit: {
        code: 'CUL/01/01',
        name: 'Introduction to Baking'
      }
    }
  end

  describe 'GET #index' do
    it 'should render index' do
      get :index, params: { school_id: course.school.id, course_id: course.id }
      expect(response).to be_successful
    end
  end

  describe 'GET #units_json' do
    it 'should return units for course' do
      get :units_json, params: { id: course.id }, format: :json
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    let(:create_request) { post :create, params: valid_attributes }
    it 'shoudld redirect when creating new unit with valid attributes' do
      create_request
      expect(response).to redirect_to(school_course_units_path(course.school, course))
      expect(flash[:notice]).to be_present
    end

    it 'shoudld create new unit with valid attributes and add to course' do
      course
      expect { create_request }.to change(Unit, :count) && change(CourseUnit, :count)
    end

    it 'should raise error when creating unit with invalid attributes' do
      post :create, params: {
        school_id: course.school.id,
        course_id: course.id,
        unit: {
          code: 'CUL/01/01',
          name: ''
        }
      }
      expect(assigns(:unit).errors.size).to be == 1
    end
  end

  describe 'POST #add_unit' do
    let(:add_request) do
      post :add_unit, params: {
        school_id: course.school.id,
        course_id: course.id,
        unit: {
          id: unit.id
        }
      }
    end

    it 'should add existing unit to course' do
      expect { add_request }.to change(CourseUnit, :count)
    end

    it 'shoudld redirect when adding existing unit' do
      add_request
      expect(response).to redirect_to(school_course_units_path(course.school, course))
      expect(flash[:notice]).to be_present
    end

    it 'should raise error when adding unit that is already in course' do
      post :add_unit, params: {
        school_id: course_unit.course.school.id,
        course_id: course_unit.course.id,
        unit: {
          id: course_unit.unit.id
        }
      }
      expect(assigns(:unit).errors.size).to be == 1
    end
  end

  describe 'DELETE #destroy' do
    let(:delete_request) do
      delete :destroy, params: {
        school_id: course_unit.course.school.id,
        course_id: course_unit.course.id,
        id: course_unit.unit.id
      }
    end

    it 'should remove unit record from course but not delete unit' do
      course_unit
      expect { delete_request }.to change(CourseUnit, :count)
      expect { delete_request }.not_to change(Unit, :count)
    end

    it 'should redirect after deleting a unit' do
      delete_request
      expect(response).to redirect_to(school_course_units_path(
                                        course_unit.course.school,
                                        course_unit.course
                                      ))
      expect(flash[:notice]).to be_present
    end
  end
end

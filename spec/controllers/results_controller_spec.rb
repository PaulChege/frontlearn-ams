# frozen_string_literal: true

require 'rails_helper'
include ActiveJob::TestHelper

RSpec.describe ResultsController, type: :controller do
  login_user
  let(:result) { create(:result) }
  let(:student) { create(:student) }
  let(:course_unit) { create(:course_unit, course_id: student.course.id) }
  let(:assessment) { create(:assessment) }

  describe 'GET #index' do
    it 'should render index' do
      get :index
      expect(response).to be_successful
    end

    it 'should show results after assessment viewing search' do
      get :index, params: {
        search: {
          unit_id: result.unit.id,
          assessment_id: result.assessment.id
        }
      }
      expect(assigns(:results).size).to be >= 1
    end
  end

  describe 'GET #search' do
    it 'should render assessment submission search' do
      result
      get :search
      expect(response).to be_successful
    end
  end

  describe 'GET #edit_all' do
    it 'should render assessment edit for already existing results' do
      get :edit_all, params: { search: {
        course_id: result.student.course.id,
        unit_id: result.unit.id,
        intake: result.student.intake,
        assessment_id: result.assessment.id
      } }
      expect(response).to be_successful
      expect(assigns(:results).size).to be >= 1
    end

    it 'should create new results and render assessment' do
      get :edit_all, params: { search: {
        course_id: student.course.id,
        unit_id: course_unit.unit.id,
        intake: student.intake,
        assessment_id: assessment.id
      } }
      expect(response).to be_successful
      expect(assigns(:results).size).to be >= 1
    end

    it 'should redirect and show notice if no results are found' do
      get :edit_all, params: { search: {
        course_id: student.course.id,
        unit_id: course_unit.unit.id,
        intake: 'Jul-2020',
        assessment_id: assessment.id
      } }
      expect(response).to be_redirect
    end
  end

  describe 'PATCH #update_all' do
    it 'should update results and calculate final marks and grades' do
      update_request =
        patch :update_all, params: {
          results: {
            result.id => {
              attendance: 10.0,
              assignments: 30.0,
              practicals: 17.0,
              cats: 22.0,
              final_exam: 40.0
            }
          },
          search: {
            assessment_id: result.assessment.id,
            course_id: result.student.course.id,
            intake: result.student.intake,
            unit_id: result.unit.id
          }
        }
      expect { update_request && result.reload }.to(
        change(result, :final_mark) && change(result, :final_grade)
      )
      expect(response).to be_redirect
    end
  end

  describe 'GET #choose_period' do
    it 'should render choose period' do
      get :choose_period
      expect(response).to be_successful
    end
  end

  describe 'POST #send_notifications' do
    ActiveJob::Base.queue_adapter = :test

    it 'should send results to students via email' do
      expect do
        perform_enqueued_jobs do
          post :send_notifications, params: { send: { assessment_id: result.assessment.id } }
        end
      end.to change { ActionMailer::Base.deliveries.size }
      expect(response).to be_redirect
    end
  end
end

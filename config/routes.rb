# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'students#index'

  resource :users,
           only: %i[delete],
           controller: 'devise/registrations',
           as: :user_registration do
    get 'cancel'
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }, skip: [:registrations]

  resources :users
  resources :schools do
    resources :courses do
      resources :units, controller: 'courses/units'
      post 'add_unit', controller: 'courses/units'
    end
  end

  namespace :courses do
    get ':id/units_json' => 'units#units_json'
  end

  resources :units, except: %i[new create]
  resources :students
  resources :assessments, except: %i[new edit]
  resources :results, only: %i[index edit]
  namespace :results do
    get 'search'
    get 'edit_all'
    patch 'update_all'
    get 'choose_period'
    post 'send_notifications'
  end
end

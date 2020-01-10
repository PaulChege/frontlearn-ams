# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#index'

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

  resources :units, except: %i[new create]
  resources :students
end

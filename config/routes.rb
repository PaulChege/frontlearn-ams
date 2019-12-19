# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#index'

  resource :users,
           only: %i[edit update delete],
           controller: 'devise/registrations',
           as: :user_registration do
    get 'cancel'
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }, skip: [:registrations]

  resources :users # creates the "normal" CRUD routes for users
end

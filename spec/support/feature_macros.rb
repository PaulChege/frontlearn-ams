# frozen_string_literal: true

include Warden::Test::Helpers

FactoryBot.define do
  module FeatureMacros
    def login_user
      # Before each test, create and login the user
      before(:each) do
        user = FactoryBot.create(:user)
        login_as(user, scope: :user)
      end
    end
  end
end

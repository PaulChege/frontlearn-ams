# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can :create, User if user.admin?
    end
  end
end

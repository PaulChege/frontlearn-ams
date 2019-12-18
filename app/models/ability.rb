# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin_role
      can :create, User
    end
  end
end

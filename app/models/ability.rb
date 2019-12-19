# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :create, User if user.admin_role
  end
end

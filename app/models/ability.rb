# frozen_string_literal: true

class Ability
  include CanCan::Ability
  delegate :create, :read, :update, :destroy, to: :crud
  delegate :create, :update, :destroy, to: :modify

  def initialize(user)
    if user
      if user.admin?
        can :crud, User
        can :crud, School 
        can :crud, Course
        can :crud, Unit
        can :crud, Assessment
        can :modify, Student
        can :read, Result
      end
    end
  end
end

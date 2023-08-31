# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    if user.present?
        if user.builder? || user.goldblum?
            can :manage, :all
        else
            can [:edit, :update], Cage
            can :manage, Dinosaur
            cannot :create, Cage
        end
    end
  end
end

class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
      can :access, :rails_admin # this line
      can :dashboard, :all # and this one
    else
      can :read, Article, active: true
      can :read, Workshop, active: true
      can :read, Lecture, active: true
    end

    if user.translator?
      can [:read, :edit, :update], Lecture
      can [:read, :edit, :update], Article
    end

    if user.volunteer?
      can :new, Lecture
      can [:create, :read, :edit, :update], Lecture, author: user
      can [:create, :read, :edit, :update], Article, lecture: { user: user }
    end
  end
end

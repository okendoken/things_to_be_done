class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user

    if user.role? :admin
      can :manage, :all
    else
      can :read, :all
      can :update, UserInfo do |user_info|
        user_info.try(:user) == user
      end
    end
  end
end
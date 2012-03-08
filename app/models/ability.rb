class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user
    can :read, :all
    can :update, UserInfo do |user_info|
      user_info.try(:user) == user
    end
    can :destroy, Comment do |comment|
      comment.user == user or comment.target.user == user
    end
  end
end
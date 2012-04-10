class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user
    can :read, :all
    can :update, UserInfo do |user_info|
      user_info.try(:user) == user
    end
    can :destroy, Comment do |comment|
      #todo user creator of project/task can delete comments? think about it
      comment.user == user or comment.target.user == user
    end
    can :destroy, Activity do |activity|
      activity.user == user or activity.participation.task.user == user
    end
    can :manage, RelatedEvent do |event|
      event.reader == user
    end
    can :manage, [Project, Task], :user_id => user.id
    can :manage, User, :id => user.id
  end
end
class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  has_many :votes, :as => :target

  include VoteTarget

  def participate_in_this(user)
    Participation.create!(:user => user, :task => self)
  end
end

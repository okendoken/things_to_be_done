class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  has_many :participations
  has_many :votes, :as => :target
  has_many :users, :through => :votes

  has_many :participants, :through => :participations, :source => :user

  include VoteTarget

  def participate_in_this(user)
    Participation.create!(:user => user, :task => self)
  end
end

class Project < ActiveRecord::Base
  belongs_to :user
  has_many :votes, :as => :target
  has_many :users, :through => :votes
  has_many :tasks

  include VoteTarget
end

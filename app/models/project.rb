class Project < ActiveRecord::Base
  belongs_to :user
  belongs_to :problem

  has_many :votes, :as => :target
  has_many :users, :through => :votes, :conditions => {:'votes.positive' => true}
  has_many :tasks

  include VoteTarget
end

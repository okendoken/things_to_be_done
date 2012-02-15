class Project < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, :use => :slugged

  belongs_to :user
  belongs_to :problem

  has_many :votes, :as => :target
  has_many :users, :through => :votes, :conditions => {:'votes.positive' => true}
  has_many :tasks

  include VoteTarget

  def should_generate_new_friendly_id?
    new_record?
  end

end

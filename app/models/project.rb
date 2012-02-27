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

  def participates_in_this?(user)
    not tasks.joins(:participations).where(:'participations.user_id' => user.id).empty?
  end

  def tasks_count
    tasks.count
  end

  def users_count
    tasks.joins(:participations).uniq.pluck(:'participations.user_id').count
  end

end

class Task < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, :use => :slugged

  belongs_to :user
  belongs_to :project

  has_many :participations
  has_many :votes, :as => :target
  has_many :users, :through => :votes, :conditions => {'votes.positive'.to_sym => true}

  has_many :participants, :through => :participations, :source => :user

  include VoteTarget

  def participate_in_this(user)
    Participation.create!(:user => user, :task => self)
  end

  def participates_in_this?(user)
    not user.nil? and Participation.where(:user_id => user.id, :task_id => self.id).exists?
  end

  def leave_this(user)
    Participation.create!(:user => user, :task => self)
  end

  def should_generate_new_friendly_id?
    new_record?
  end

  def users_count
    participations.count
  end

end

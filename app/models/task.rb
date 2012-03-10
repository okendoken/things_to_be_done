class Task < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, :use => :slugged

  belongs_to :user
  belongs_to :project

  has_many :participations
  has_many :votes, :as => :target
  has_many :comments, :as => :target
  has_many :users, :through => :votes, :conditions => {:'votes.positive' => true}

  has_many :participants, :through => :participations, :source => :user

  has_many :related_events, :as => :reader

  include VoteTarget

  def participate_in_this(user)
    raise 'Not logged in' if user.nil?
    unless self.participates_in_this?(user)
      participation = Participation.create!(:user => user, :task => self)
      RelatedEvent.notify_all(participation, :added, user)
    end
  end

  def participates_in_this?(user)
    not user.nil? and Participation.where(:user_id => user.id, :task_id => self.id).exists?
  end

  def leave_this(user)
    if part = Participation.where(:user_id => user.id, :task_id => self.id)[0]
      part.destroy
    end
  end

  def should_generate_new_friendly_id?
    new_record?
  end

  def users_count
    participations.count
  end

end

class Task < ActiveRecord::Base
  extend FriendlyId
  include Votable
  include Commentable
  include EventEnvironment
  include Readable
  friendly_id :title, :use => :slugged

  belongs_to :user
  belongs_to :project
  belongs_to :city

  has_many :participations
  has_many :votes, :as => :target
  has_many :comments, :as => :target
  has_many :users, :through => :votes, :conditions => {:'votes.positive' => true}

  has_many :participants, :through => :participations, :source => :user,
           :conditions => "participations.status != #{PARTICIPATION_STATUS[:canceled]}"

  has_many :activities, :through => :participations

  has_many :related_events, :as => :reader

  before_destroy :destroy_events

  def participate_in_this(user)
    raise 'Not logged in' if user.nil?
    participation = Participation.where(:user_id => user.id, :task_id => self.id)[0] || Participation.new(:user => user, :task => self)
    participation.status = PARTICIPATION_STATUS[:in_progress]
    participation.save
    on_participate participation, user
  end

  def participates_in_this?(user)
    not user.nil? and Participation.where(:user_id => user.id, :task_id => self.id,
                                          :status => PARTICIPATION_STATUS[:in_progress]).exists?
  end

  def leave_this(user)
    if part = Participation.where(:user_id => user.id, :task_id => self.id)[0]
      part.status = PARTICIPATION_STATUS[:canceled]
      part.save
      on_leave part, user
    end
  end

  def should_generate_new_friendly_id?
    new_record?
  end

  def users_count
    participants.count
  end

  #create new activity
  def commit_this(text, user, status = ACTIVITY_STATUS[:in_progress])
    participation = Participation.where(:user_id => user.id, :task_id => self.id)[0]
    activity = participation.activities.create!(:user => user, :text => text, :status => status)
    on_commit activity, user
    activity
  end

  def change_status(status, user)
    self.status = TASK_STATUS[status]
    self.save
    on_status_change status, user
  end

  private

  def on_participate(participation, user)
    RelatedEvent.notify_all(participation, :added, user)
    change_related_rating participation, :added
  end

  def on_leave(part, user)
    RelatedEvent.notify_all(part, :canceled, user)
    change_related_rating part, :canceled
  end

  def on_commit(activity, user)
    RelatedEvent.notify_all(activity, :added, user)
    change_related_rating activity, :added
  end

  def on_status_change(status, user)
    RelatedEvent.notify_all self, status, user
    change_related_rating self, status
  end

end

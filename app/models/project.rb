class Project < ActiveRecord::Base
  include Readable
  include Votable
  include Commentable
  extend FriendlyId
  friendly_id :title, :use => :slugged

  belongs_to :user
  belongs_to :problem

  has_many :votes, :as => :target
  has_many :comments, :as => :target
  has_many :users, :through => :votes, :conditions => {:'votes.positive' => true}
  has_many :tasks

  has_many :related_events, :as => :reader

  before_destroy :destroy_events

  def should_generate_new_friendly_id?
    new_record?
  end

  def participates_in_this?(user)
    not user.nil? and not tasks.joins(:participations).where(:'participations.user_id' => user.id).empty?
  end

  def tasks_count
    tasks.count
  end

  def users_count
    tasks.joins(:participations).uniq.pluck(:'participations.user_id').count
  end

  def activities
    Activity.joins(:participation => :task).where(:'tasks.project_id' => self.id)
  end

end

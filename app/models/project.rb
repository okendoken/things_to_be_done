class Project < ActiveRecord::Base
  include Readable
  include Votable
  include Commentable
  extend FriendlyId
  friendly_id :title, :use => :slugged

  belongs_to :user
  belongs_to :problem
  belongs_to :city

  has_many :votes, :as => :target
  has_many :comments, :as => :target
  has_many :users, :through => :votes, :conditions => {:'votes.positive' => true}
  has_many :tasks

  has_many :related_events, :as => :reader

  has_attached_file :avatar, :default_url => "/images/bruce.jpg", :styles => { :medium => "220", :thumbnail => "75x75" }

  validates_attachment :avatar, :content_type => { :content_type => /image/ },
                       :size => { :in => 0..5.megabytes}

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

  def change_status(status, user)
    self.status = PROJECT_STATUS[status]
    self.save
    on_status_change status, user
  end

  def participants
    User.joins(:participations => :task).where(:'tasks.project_id' => self.id).uniq
  end

  def most_valuable_tasks
    tasks.order(<<-SQL
        ifnull((select vp - vn as rating from (
                      select
                              (select count(*) from votes where positive = 't'
                                                and target_type = 'Task'
                                                and target_id = tasks.id) as vp,
                              (select count(*) from votes where positive = 'f'
                                                and target_type = 'Task'
                                                and target_id = tasks.id) as vn
                    )
            ), 0) desc
    SQL
    )
  end

  private

  def on_status_change(status, user)
    RelatedEvent.notify_all self, status, user
    change_related_rating self, status
  end

end

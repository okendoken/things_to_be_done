class User < ActiveRecord::Base
  after_create :create_related_user_info
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  validates :nickname, :presence => true

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :nickname

  # user information
  has_one :user_info

  #actually for now it's has_one, but I decided to leave has_many
  #twitter, FB, VK accounts...
  has_many :authorizations

  #direct associations
  #user created projects
  has_many :created_projects, :class_name => 'Project'
  #user created tasks
  has_many :created_tasks, :class_name => 'Task'
  #user votes
  has_many :votes
  #user participations. for now it's pseudo model to provide many-to-many association.
  #Daniel said "We are going to control everything!!!"
  has_many :participations
  #user active tasks
  has_many :tasks, :class_name => 'Task', :through => :participations

  #many-to-many indirect polymorphic associations
  #projects, user has voted for
  has_many :voted_projects, :through => :votes, :source => :target, :source_type => 'Project', :conditions => {:'votes.positive' => true}
  #tasks user has voted for
  has_many :voted_tasks, :through => :votes, :source => :target, :source_type => 'Task', :conditions => {:'votes.positive' => true}

  #events user need to handle
  has_many :related_events, :as => :reader
  #events user created
  has_many :created_related_events, :class_name => 'RelatedEvent'

  #oauth stuff

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if user = User.where(:email => data.email).first
      user
    else
      # Create a user with a stub password.
      user = User.create!(:email => data.email, :password => Devise.friendly_token[0,20], :nickname => data.name)
      auth = user.authorizations.build(:uid => access_token['uid'], :token => access_token['credentials']['token'],
                                       :secret => nil, :name => data.name, :link => data.link, :provider => 'facebook')
      user.authorizations << auth
      user
    end
  end

  def self.find_for_twitter_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if auth = Authorization.find_by_uid(access_token['uid'])
      auth.user
    else
      nil
    end
  end

  def self.find_for_vkontakte_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if auth = Authorization.find_by_uid(access_token['uid'])
      auth.user
    else
      nil
    end
  end

  def display_name
    self.nickname
  end

  private
  def create_related_user_info
    self.user_info = UserInfo.create!
  end
end

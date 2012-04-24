class UserInfo < ActiveRecord::Base
  belongs_to :user
  belongs_to :city

  has_many :related_events, :as => :reader

  has_attached_file :avatar, :default_url => "/images/avatar.jpg"
  validates_attachment :avatar, :content_type => { :content_type => "image/*" },
                       :size => { :in => 0..5.megabytes}

  attr_accessible :avatar, :first_name, :last_name, :about_myself
end

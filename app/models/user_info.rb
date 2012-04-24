class UserInfo < ActiveRecord::Base
  belongs_to :user
  belongs_to :city

  has_many :related_events, :as => :reader

  has_attached_file :avatar, :default_url => "/images/bruce.jpg"

  attr_accessible :avatar, :first_name, :last_name, :about_myself
end

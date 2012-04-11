class UserInfo < ActiveRecord::Base
  belongs_to :user
  belongs_to :city

  has_many :related_events, :as => :reader

  has_attached_file :avatar,
                    :styles => { :medium => "300x300>",
                                 :thumb => "100x100>" }

  attr_accessible :avatar, :first_name, :last_name, :about_myself
end

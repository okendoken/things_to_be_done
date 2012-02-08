class Project < ActiveRecord::Base
  belongs_to :creator, :class_name => 'User'
  has_many :votes, :as => :target
  has_many :users, :through => :votes

end

class Task < ActiveRecord::Base
  belongs_to :creator, :class_name => 'User'
  belongs_to :project

  has_many :votes, :as => :target

end

class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  has_many :votes, :as => :target

  def creator
    self.user
  end
end

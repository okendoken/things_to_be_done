class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  def creator
    self.user
  end
end

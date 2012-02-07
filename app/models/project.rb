class Project < ActiveRecord::Base
  belongs_to :user

  def creator
    self.user
  end
end

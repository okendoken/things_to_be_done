class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  has_many :votes, :as => :target

  #todo extract to superclass!!!
  def vote_for_this(user)
    Vote.create!(:positive => true, :user => user, :target => self)
  end

  def participate_in_this(user)
    Participation.create!(:user => user, :task => self)
  end

  def desc_short
    self.description.length > 20 ? self.description.slice(0,20) : self.description
  end
end

class Project < ActiveRecord::Base
  belongs_to :user
  has_many :votes, :as => :target
  has_many :users, :through => :votes
  has_many :tasks

  #todo extract to superclass!!!
  def vote_for_this(user)
    Vote.create!(:positive => true, :user => user, :target => self)
  end

  def desc_short
    self.description.length > 20 ? self.description.slice(0,20) : self.description
  end

end

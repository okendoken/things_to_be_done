module VoteTarget

  def vote_for_this(user)
    Vote.create!(:positive => true, :user => user, :target => self)
  end

  def desc_short
    self.description.length > 50 ? self.description.slice(0,50) + '...' : self.description
  end

end
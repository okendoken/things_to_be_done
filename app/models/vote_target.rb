module VoteTarget

  def vote_for_this(user, positive = true)
    Vote.create!(:positive => positive, :user => user, :target => self)
  end

  def desc_short
    self.description.length > 50 ? self.description.slice(0,50) + '...' : self.description
  end

  def user_vote(user)
    self.votes.where(:user_id => user.id)[0]
  end

end
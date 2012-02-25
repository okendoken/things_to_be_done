module VoteTarget

  def vote_for_this(user, positive = true)
    Vote.create!(:positive => positive, :user => user, :target => self)
  end

  def desc_short
    self.description.length > 120 ? self.description.slice(0,120) + '...' : self.description
  end

  def desc_sliced_1000
    desc_more_than_1000? ? self.description.slice(0,1000) : self.description
  end

  def desc_from_1000
    desc_more_than_1000? ? self.description.slice(1000, self.description.length) : ''
  end

  def desc_more_than_1000?
    self.description.length > 1000
  end

  def user_vote(user)
    self.votes.where(:user_id => user.id)[0] unless user.nil?
  end

  def rating
    positive = Hash[*Vote.select('count(id) count, positive').group('positive').where('target_id = ? and target_type = ?', self.id, self.class.name).collect{ |vote|
      [vote.positive.to_s, vote.count]}.flatten]
    nvl(positive["true"]) - nvl(positive["false"])
  end

  def votes_count
    self.votes.count
  end

  private

  def nvl(a)
    a.nil? ? 0 : a
  end

end
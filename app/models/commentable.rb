module Commentable
  def comment_this(text, user)
    comment = self.comments.create!(:user => user, :text => text)
    RelatedEvent.notify_all(comment, :added, user)
    comment
  end
end
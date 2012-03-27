module Commentable
  def comment_this(text, user)
    comment = self.comments.create!(:user => user, :text => text)
    on_comment comment, user
    comment
  end

  private

  def on_comment(comment, user)
    RelatedEvent.notify_all(comment, :added, user)
    change_related_rating comment, :added
  end
end
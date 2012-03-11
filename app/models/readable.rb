module Readable
  def destroy_events
    RelatedEvent.destroy_all(:readable_id => self.id, :readable_type => self.class.name)
  end
end
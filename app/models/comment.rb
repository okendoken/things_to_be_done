class Comment < ActiveRecord::Base
  include Readable
  belongs_to :target, :polymorphic => true
  belongs_to :user

  validates :text, :presence => true

  before_destroy :destroy_events
end

class Vote < ActiveRecord::Base
  include Readable
  #target can be project or task
  belongs_to :target, :polymorphic => true
  belongs_to :user

  before_destroy :destroy_events
end

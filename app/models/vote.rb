class Vote < ActiveRecord::Base
  #target can be project or task
  belongs_to :target, :polymorphic => true
  belongs_to :user
end

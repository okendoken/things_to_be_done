class Comment < ActiveRecord::Base
  belongs_to :target, :polymorphic => true
  belongs_to :user

  validates :text, :presence => true
end

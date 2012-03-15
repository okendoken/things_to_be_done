class Comment < ActiveRecord::Base
  include Readable
  include Votable
  belongs_to :target, :polymorphic => true
  belongs_to :user

  has_many :votes, :as => :target

  validates :text, :presence => true

  before_destroy :destroy_events
end

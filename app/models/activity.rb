class Activity < ActiveRecord::Base
  include Readable
  include Votable
  belongs_to :participation
  belongs_to :user

  has_many :comments, :as => :target
  has_many :votes, :as => :target

  validates :text, :presence => true

  before_destroy :destroy_events
end

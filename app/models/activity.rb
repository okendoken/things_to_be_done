class Activity < ActiveRecord::Base
  include Readable
  belongs_to :participation
  belongs_to :user

  has_many :comments, :as => :target
  has_many :votes, :as => :target

  validates :text, :presence => true

  before_destroy :destroy_events
end

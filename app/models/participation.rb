class Participation < ActiveRecord::Base
  include Readable
  belongs_to :task
  belongs_to :user

  has_many :activities

  before_destroy :destroy_events
end

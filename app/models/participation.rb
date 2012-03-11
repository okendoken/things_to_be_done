class Participation < ActiveRecord::Base
  include Readable
  belongs_to :task
  belongs_to :user

  before_destroy :destroy_events
end

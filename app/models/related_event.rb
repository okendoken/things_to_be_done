class RelatedEvent < ActiveRecord::Base
  include EventEnvironment

  belongs_to :readable, :polymorphic => true
  belongs_to :reader, :polymorphic => true
  belongs_to :user

  validates :e_type, :presence => true

  attr_accessible :e_type, :read, :readable, :reader, :user

  def self.notify_all(readable, type, user)
    clazz = readable.class.name.downcase  .to_sym
    EVENT_READERS[clazz][type].call(readable).each do |reader|
      RelatedEvent.create!(:e_type => DB_EVENT_TYPES[clazz][type], :read => false,
                           :readable => readable, :reader => reader, :user => user)
    end
  end

end

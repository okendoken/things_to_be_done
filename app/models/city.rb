class City < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :slugged

  belongs_to :country
  has_many :projects
  has_many :tasks
  has_many :users, :through => :user_infos

  def should_generate_new_friendly_id?
    new_record?
  end

  def display_name
    "#{self.name}, #{self.country.name}"
  end
end

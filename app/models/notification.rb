class Notification < ActiveRecord::Base
  belongs_to :stuff_to_process, :polymorphic => true
  belongs_to :user
  belongs_to :sender, :class_name => "User"
end

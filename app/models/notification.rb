class Notification < ActiveRecord::Base
  belongs_to :stuff_to_process, :polymorphic => true
  belongs_to :user
  belongs_to :sender, :class_name => "User"

  def self.create_notification(type, sender, stuff_to_process)
    Notification.Create(:user => stuff_to_process.user,
                        :read => false,
                        :sender => sender,
                        :type => type,
                        :stuff_to_process => stuff_to_process)
  end
end

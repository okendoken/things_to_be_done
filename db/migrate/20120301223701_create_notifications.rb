class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :type
      t.boolean :read
      t.references :stuff_to_process, :polymorphic => true
      t.references :user
      t.references :sender
      t.timestamps :time
    end
    add_index :notifications, :user_id
    add_index :notifications, :sender_id
    add_index :notifications, :stuff_to_process_id
    add_index :notifications, :stuff_to_process_type
  end
end

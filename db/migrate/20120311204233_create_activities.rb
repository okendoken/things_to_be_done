class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.references :participation
      t.text :text, :null => false, :default => ""
      t.integer :status, :null => false, :default => ACTIVITY_STATUS[:in_progress]
      t.references :user

      t.timestamps
    end
    add_index :activities, :participation_id
    add_index :activities, :user_id
  end
end

class CreateRelatedEvents < ActiveRecord::Migration
  def change
    create_table :related_events do |t|
      t.integer :e_type
      t.boolean :read
      t.references :readable, :polymorphic => true
      t.references :reader, :polymorphic => true
      t.references :user

      t.timestamps
    end
    add_index :related_events, :readable_id
    add_index :related_events, :readable_type
    add_index :related_events, :reader_id
    add_index :related_events, :reader_type
    add_index :related_events, :user_id
  end
end

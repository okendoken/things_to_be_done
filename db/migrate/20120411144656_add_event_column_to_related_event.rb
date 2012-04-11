class AddEventColumnToRelatedEvent < ActiveRecord::Migration
  def change
    change_table :related_events do |t|
      t.references :event
    end
    add_index :related_events, :event_id

  end
end

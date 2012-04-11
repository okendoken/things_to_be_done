class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :user
      t.integer :e_type

      t.timestamps
    end
    add_index :events, :user_id
  end
end

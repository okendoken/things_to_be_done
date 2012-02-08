class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.boolean :positive
      t.references :target, :polymorphic => true
      t.references :user

      t.timestamps
    end
    add_index :votes, :target_id
    add_index :votes, :target_type
    add_index :votes, :user_id
  end
end

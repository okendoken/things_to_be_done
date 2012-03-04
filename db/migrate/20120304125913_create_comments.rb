class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :text
      t.references :target, :polymorphic => true
      t.references :user

      t.timestamps
    end
    add_index :comments, :target_id
    add_index :comments, :target_type
    add_index :comments, :user_id
  end
end
